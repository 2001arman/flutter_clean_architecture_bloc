import 'package:dartz/dartz.dart';

import 'exceptions.dart';
import 'failures.dart';

Either<Failure, T> handleException<T>(T Function() action) {
  try {
    return Right(action());
  } catch (e) {
    return Left(_mapExceptionToFailure(e));
  }
}

Future<Either<Failure, T>> handleExceptionAsync<T>(
  Future<T> Function() action,
) async {
  try {
    return Right(await action());
  } catch (e) {
    return Left(_mapExceptionToFailure(e));
  }
}

Failure _mapExceptionToFailure(Object e) => switch (e) {
  UserNotFoundException() => Failure.userNotFoundFailure(message: e.message),
  WrongPasswordException() => Failure.wrongPasswordFailure(message: e.message),
  EmailAlreadyInUseException() => Failure.emailAlreadyInUseFailure(
    message: e.message,
  ),
  WeakPasswordException() => Failure.weakPasswordFailure(message: e.message),
  NetworkException() => Failure.networkFailure(message: e.message),
  FirebaseAuthException() => Failure.serverFailure(message: e.message),
  _ => Failure.unknownFailure(message: e.toString()),
};
