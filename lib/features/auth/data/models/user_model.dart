import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;

  UserModel({required this.uid, required this.email, required this.name});

  factory UserModel.fromJsonId({
    required String uid,
    required Map<String, dynamic> json,
  }) {
    return UserModel(uid: uid, email: json['email'], name: json['name']);
  }

  UserEntity toEntity() => UserEntity(uid: uid, name: name, email: email);
}
