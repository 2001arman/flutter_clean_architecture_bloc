import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/error_handler.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<UserEntity?> get authStateChange => throw UnimplementedError();

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async =>
      handleExceptionAsync(() async {
        final model = await _dataSource.getCurrentUser();

        return model.toEntity();
      });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) => handleExceptionAsync(() async {
    final model = await _dataSource.login(email: email, password: password);
    return model.toEntity();
  });

  @override
  Future<Either<Failure, void>> logout() => handleExceptionAsync(() async {
    return _dataSource.logout();
  });

  @override
  Future<Either<Failure, UserEntity>> register({
    required String fullName,
    required String email,
    required String password,
  }) => handleExceptionAsync(() async {
    final model = await _dataSource.register(
      name: fullName,
      email: email,
      password: password,
    );
    return model.toEntity();
  });
}
