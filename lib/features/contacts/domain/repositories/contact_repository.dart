import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactEntity>>> getContactData();
}
