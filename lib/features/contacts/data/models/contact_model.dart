import 'package:flutter_clean_architecture_bloc/features/contacts/domain/entities/contact_entity.dart';

class ContactModel {
  final String userId;
  final String email;
  final String name;

  ContactModel({required this.userId, required this.email, required this.name});

  factory ContactModel.fromJsonId({
    required String userId,
    required Map<String, dynamic> json,
  }) {
    return ContactModel(
      userId: userId,
      email: json['email'],
      name: json['name'],
    );
  }

  ContactEntity toEntity() => ContactEntity(userId: userId, name: name);
}
