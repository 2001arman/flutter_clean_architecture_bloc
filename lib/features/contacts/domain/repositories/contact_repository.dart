import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<UserEntity>>> getContactData();
}
