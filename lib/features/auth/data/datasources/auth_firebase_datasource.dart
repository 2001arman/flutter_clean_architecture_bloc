import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart' as exception;
import 'package:flutter_clean_architecture_bloc/features/auth/data/models/user_model.dart';

abstract class AuthFirebaseDataSource {
  Future<UserModel> login({required String email, required String password});
}

@LazySingleton(as: AuthFirebaseDataSource)
class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthFirebaseDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel.fromFirebase(credential.user!);
    } on FirebaseAuthException catch (e) {
      _mapFirebaseException(e);
    } catch (e) {
      throw exception.FirebaseAuthException(message: 'Unknown Error');
    }
  }

  Never _mapFirebaseException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        throw exception.UserNotFoundException(
          message: 'Email format is not correct.',
        );
      case 'user-not-found':
        throw exception.UserNotFoundException(
          message: 'No user found with this email.',
        );
      case 'wrong-password':
      case 'invalid-credential':
        throw exception.WrongPasswordException(
          message: 'Incorrect email or password.',
        );
      case 'email-already-in-use':
        throw exception.EmailAlreadyInUseException(
          message: 'This email is already registered.',
        );
      case 'weak-password':
        throw exception.WeakPasswordException(
          message: 'Password is too weak. Minimum 6 characters.',
        );
      case 'network-request-failed':
        throw exception.NetworkException(message: 'No internet connection.');
      default:
        throw exception.FirebaseAuthException(
          message: e.message ?? 'Authentication failed.',
          code: e.code,
        );
    }
  }
}
