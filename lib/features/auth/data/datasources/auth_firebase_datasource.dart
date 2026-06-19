import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_bloc/core/error/firebase_exception_mapper.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart' as exception;
import 'package:flutter_clean_architecture_bloc/features/auth/data/models/user_model.dart';

abstract class AuthFirebaseDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();
}

@LazySingleton(as: AuthFirebaseDataSource)
class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthFirebaseDataSourceImpl(this._firebaseAuth, this._firestore);

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

      if (credential.user == null) {
        throw exception.UserNotFoundException(
          message: 'No user found with this email.',
        );
      }

      final userFirestore = await _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .get();

      if (!userFirestore.exists) {
        throw exception.UserNotFoundException(
          message: 'No user found with this email.',
        );
      }

      return UserModel.fromJsonId(
        uid: credential.user!.uid,
        json: userFirestore.data()!,
      );
    } on FirebaseAuthException catch (e) {
      e.toAppException();
    } catch (e) {
      throw exception.FirebaseAuthException(message: 'Unknown Error');
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(credential.user!.uid).set({
        'name': name,
        'email': email,
      });

      return UserModel(uid: credential.user!.uid, email: email, name: name);
    } on FirebaseAuthException catch (e) {
      e.toAppException();
    } catch (e) {
      throw exception.FirebaseAuthException(message: "Unknown Error");
    }
  }

  @override
  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw exception.UserNotFoundException(
          message: "Current User Not Found",
        );
      }
      final uid = _firebaseAuth.currentUser!.uid;

      final user = await _firestore.collection('users').doc(uid).get();

      if (_firebaseAuth.currentUser == null) {
        throw exception.UserNotFoundException(
          message: "Current User Not Found",
        );
      }

      return UserModel.fromJsonId(uid: uid, json: user.data()!);
    } on FirebaseAuthException catch (e) {
      e.toAppException();
    } catch (e) {
      throw exception.FirebaseAuthException(message: "Unknown Error");
    }
  }
}
