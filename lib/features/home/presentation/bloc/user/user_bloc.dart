import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/usecase/load_current_user_use_case.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/usecase/logout_use_case.dart';
import 'package:injectable/injectable.dart';

import 'user_event.dart';
import 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final LogoutUseCase _logoutUseCase;
  final LoadCurrentUserUseCase _loadCurrentUserUseCase;

  UserBloc(this._logoutUseCase, this._loadCurrentUserUseCase)
    : super(UserState.initial()) {
    on<UserEventLogout>(_logout);
    on<LoadCurrentUser>(_loadCurrentUser);
  }

  void _loadCurrentUser(UserEvent event, Emitter<UserState> emit) async {
    emit(UserState.loading());

    final result = await _loadCurrentUserUseCase.call(NoParams());

    result.fold(
      (failure) => emit(UserState.error(message: failure.message)),
      (user) => emit(UserState.loaded(user: user)),
    );
  }

  void _logout(UserEvent event, Emitter<UserState> emit) async {
    emit(UserState.loading());

    final result = await _logoutUseCase.call(NoParams());

    result.fold((failure) {
      final currentState = state;
      if (currentState is UserLoaded) {
        emit(
          UserState.loaded(
            user: currentState.user,
            errorMessage: failure.message,
          ),
        );
      }
    }, (_) {});
  }
}
