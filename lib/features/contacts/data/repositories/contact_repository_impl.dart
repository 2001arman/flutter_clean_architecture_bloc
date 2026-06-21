import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_datasource.dart';

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
