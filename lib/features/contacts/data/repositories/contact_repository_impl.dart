import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/error_handler.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/data/datasources/contact_datasource.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/domain/repositories/contact_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/domain/entities/user_entity.dart';

@LazySingleton(as: ContactRepository)
class ContactRepositoryImpl implements ContactRepository {
  final ContactDataSource _dataSource;

  ContactRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> getContactData() async =>
      handleExceptionAsync(() async {
        final data = await _dataSource.getContacts();
        return data.map((contact) => contact.toEntity()).toList();
      });
}
