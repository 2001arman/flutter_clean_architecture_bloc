import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState.initial() = UserIntial;
  const factory UserState.loading() = UserLoading;
  const factory UserState.loaded({
    required UserEntity user,
    String? errorMessage,
  }) = UserLoaded;
  const factory UserState.error({required String message}) = UserError;
}
