import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

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
