import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoadCurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository _repository;

  LoadCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return _repository.getCurrentUser();
  }
}
