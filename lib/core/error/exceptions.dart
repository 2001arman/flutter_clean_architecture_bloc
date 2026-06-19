class FirebaseAuthException implements Exception {
  final String message;
  final String? code;

  FirebaseAuthException({required this.message, this.code});
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException({required this.message});
}

class EmailAlreadyInUseException implements Exception {
  final String message;

  EmailAlreadyInUseException({required this.message});
}

class WeakPasswordException implements Exception {
  final String message;

  WeakPasswordException({required this.message});
}

class WrongPasswordException implements Exception {
  final String message;

  WrongPasswordException({required this.message});
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});
}

class PermissionDeniedException implements Exception {
  final String message;
  const PermissionDeniedException({required this.message});
}

class DocumentNotFoundException implements Exception {
  final String message;
  const DocumentNotFoundException({required this.message});
}

class DocumentAlreadyExistsException implements Exception {
  final String message;
  const DocumentAlreadyExistsException({required this.message});
}

class FailedPreconditionException implements Exception {
  final String message;
  const FailedPreconditionException({required this.message});
}

class OperationAbortedException implements Exception {
  final String message;
  const OperationAbortedException({required this.message});
}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException({required this.message});
}

class OperationCancelledException implements Exception {
  final String message;
  const OperationCancelledException({required this.message});
}

class ResourceExhaustedException implements Exception {
  final String message;
  const ResourceExhaustedException({required this.message});
}

class UnauthenticatedException implements Exception {
  final String message;
  const UnauthenticatedException({required this.message});
}

class FirebaseFirestoreException implements Exception {
  final String message;
  const FirebaseFirestoreException({required this.message});
}
