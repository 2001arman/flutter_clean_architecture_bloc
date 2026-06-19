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
