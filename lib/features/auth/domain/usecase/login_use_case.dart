import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_use_case.freezed.dart';

@freezed
abstract class LoginParams with _$LoginParams {
  const factory LoginParams({required String email, required String password}) =
      _LoginParams;
}

@lazySingleton
class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}
