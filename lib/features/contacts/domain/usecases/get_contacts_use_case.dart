import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/contact_repository.dart';

@lazySingleton
class GetContactsUseCase implements UseCase<List<UserEntity>, NoParams> {
  final ContactRepository _contactRepository;

  GetContactsUseCase(this._contactRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return _contactRepository.getContactData();
  }
}
