import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'exceptions.dart';

extension FirebaseAuthExceptionMapper on fb.FirebaseAuthException {
  Never toAppException() {
    switch (code) {
      case 'invalid-email':
        throw UserNotFoundException(message: 'Email format is not correct.');
      case 'user-not-found':
        throw UserNotFoundException(message: 'No user found with this email.');
      case 'wrong-password':
      case 'invalid-credential':
        throw WrongPasswordException(message: 'Incorrect email or password.');
      case 'email-already-in-use':
        throw EmailAlreadyInUseException(
          message: 'This email is already registered.',
        );
      case 'weak-password':
        throw WeakPasswordException(
          message: 'Password is too weak. Minimum 6 characters.',
        );
      case 'network-request-failed':
        throw NetworkException(message: 'No internet connection.');
      default:
        throw FirebaseAuthException(
          message: message ?? 'Authentication failed.',
          code: code,
        );
    }
  }
}

extension FirestoreExceptionMapper on FirebaseException {
  Never toAppException() {
    switch (code) {
      case 'permission-denied':
        throw PermissionDeniedException(
          message: 'You do not have permission to perform this action.',
        );

      case 'not-found':
        throw DocumentNotFoundException(
          message: 'The requested document was not found.',
        );

      case 'already-exists':
        throw DocumentAlreadyExistsException(
          message: 'The document already exists.',
        );

      case 'failed-precondition':
        throw FailedPreconditionException(
          message: 'Operation failed due to an invalid system state.',
        );

      case 'aborted':
        throw OperationAbortedException(
          message: 'The operation was aborted. Please try again.',
        );

      case 'unavailable':
        throw NetworkException(
          message: 'Service is currently unavailable. Please try again later.',
        );

      case 'deadline-exceeded':
        throw TimeoutException(
          message: 'The request timed out. Please try again.',
        );

      case 'cancelled':
        throw OperationCancelledException(
          message: 'The operation was cancelled.',
        );

      case 'resource-exhausted':
        throw ResourceExhaustedException(
          message: 'Resource limit exceeded. Please try again later.',
        );

      case 'unauthenticated':
        throw UnauthenticatedException(message: 'Please sign in to continue.');

      default:
        throw FirebaseFirestoreException(
          message: message ?? 'Something went wrong.',
        );
    }
  }
}
