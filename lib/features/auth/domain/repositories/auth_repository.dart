import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  Either<Failure, UserEntity> getCurrentUser();

  Stream<UserEntity?> get authStateChange;
}
