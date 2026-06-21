import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_bloc/core/error/firebase_exception_mapper.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart' as exception;
import '../../../auth/data/models/user_model.dart';

abstract class ContactDataSource {
  Future<List<UserModel>> getContacts();
}

@LazySingleton(as: ContactDataSource)
class ContactDataSourceImpl implements ContactDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  ContactDataSourceImpl(this._firestore, this._firebaseAuth);

  @override
  Future<List<UserModel>> getContacts() async {
    try {
      final currentId = _firebaseAuth.currentUser!.uid;

      final snapshot = await _firestore.collection('users').get();

      final contacts = snapshot.docs
          .where((doc) => doc.id != currentId)
          .map((doc) => UserModel.fromJsonId(uid: doc.id, json: doc.data()))
          .toList();

      return contacts;
    } on FirebaseException catch (e) {
      e.toAppException();
    } catch (e) {
      throw exception.FirebaseFirestoreException(message: 'Unknown Error');
    }
  }
}
