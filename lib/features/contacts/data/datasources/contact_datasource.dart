import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_bloc/core/error/firebase_exception_mapper.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/data/models/contact_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart' as exception;

abstract class ContactDataSource {
  Future<List<ContactModel>> getContacts();
}

@LazySingleton(as: ContactDataSource)
class ContactDataSourceImpl implements ContactDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  ContactDataSourceImpl(this._firestore, this._firebaseAuth);

  @override
  Future<List<ContactModel>> getContacts() async {
    try {
      final currentId = _firebaseAuth.currentUser!.uid;

      final snapshot = await _firestore.collection('users').get();

      final contacts = snapshot.docs
          .where((doc) => doc.id != currentId)
          .map(
            (doc) => ContactModel.fromJsonId(userId: doc.id, json: doc.data()),
          )
          .toList();

      return contacts;
    } on FirebaseException catch (e) {
      e.toAppException();
    } catch (e) {
      throw exception.FirebaseFirestoreException(message: 'Unknown Error');
    }
  }
}
