import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String email;
  final String fullName;

  UserModel({required this.uid, required this.email, required this.fullName});

  factory UserModel.fromFirebase(fb.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      fullName: user.displayName ?? '',
    );
  }

  UserEntity toEntity() =>
      UserEntity(uid: uid, fullName: fullName, email: email);
}
