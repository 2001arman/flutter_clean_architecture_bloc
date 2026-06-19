import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'register_use_case.freezed.dart';

@freezed
abstract class RegisterParam with _$RegisterParam {
  const factory RegisterParam({
    required String name,
    required String email,
    required String password,
  }) = _RegisterParam;
}

@lazySingleton
class RegisterUseCase implements UseCase<UserEntity, RegisterParam> {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParam params) {
    return _repository.register(
      fullName: params.name,
      email: params.email,
      password: params.password,
    );
  }
}
