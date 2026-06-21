import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class LoadCurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository _repository;

  LoadCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return _repository.getCurrentUser();
  }
}
