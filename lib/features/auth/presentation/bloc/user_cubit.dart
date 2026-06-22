import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecase/load_current_user_use_case.dart';
import '../../domain/usecase/logout_use_case.dart';

part 'user_cubit.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState.initial() = UserIntial;
  const factory UserState.loading() = UserLoading;
  const factory UserState.loaded({required UserEntity user}) = UserLoaded;
  const factory UserState.error({required String message}) = UserError;
}

@injectable
class UserCubit extends Cubit<UserState> {
  final LogoutUseCase _logoutUseCase;
  final LoadCurrentUserUseCase _loadCurrentUserUseCase;
  UserCubit(this._logoutUseCase, this._loadCurrentUserUseCase)
    : super(UserIntial());

  Future<void> loadCurrentUser() async {
    emit(UserState.loading());

    final result = await _loadCurrentUserUseCase.call(NoParams());

    result.fold(
      (failure) => emit(UserState.error(message: failure.message)),
      (user) => emit(UserState.loaded(user: user)),
    );
  }

  Future<void> logout() async {
    emit(UserState.loading());

    final result = await _logoutUseCase.call(NoParams());

    result.fold((failure) {
      final currentState = state;
      if (currentState is UserLoaded) {
        emit(UserState.loaded(user: currentState.user));
      }
    }, (_) {});
  }
}
