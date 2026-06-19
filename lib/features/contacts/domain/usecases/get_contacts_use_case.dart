import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/domain/entities/contact_entity.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/domain/repositories/contact_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetContactsUseCase implements UseCase<List<ContactEntity>, NoParams> {
  final ContactRepository _contactRepository;

  GetContactsUseCase(this._contactRepository);

  @override
  Future<Either<Failure, List<ContactEntity>>> call(NoParams params) async {
    return _contactRepository.getContactData();
  }
}
