import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/chat_room.dart';
import 'message_model.dart';

class ChatRoomModel {
  final String id;
  final List<UserModel> participants;
  final List<String> participantIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  MessageModel? lastMessage;

  ChatRoomModel({
    required this.id,
    required this.participants,
    required this.participantIds,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
  });

  factory ChatRoomModel.fromJsonId({
    required String id,
    required Map<String, dynamic> json,
  }) => ChatRoomModel(
    id: id,
    participants: (json['participants'] as List)
        .map(
          (data) => UserModel(
            uid: data['uid'],
            email: data['email'],
            name: data['name'],
          ),
        )
        .toList(),
    participantIds: (json['participant_ids'] as List)
        .map((data) => data.toString())
        .toList(),
    lastMessage: (json['last_message'] != null)
        ? MessageModel.fromJson(json: json['last_message'])
        : null,
    createdAt: (json['created_at'] as Timestamp).toDate(),
    updatedAt: (json['updated_at'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    'participants': participants
        .map(
          (user) => {'uid': user.uid, 'email': user.email, 'name': user.name},
        )
        .toList(),
    'participant_ids': participantIds,
    'created_at': FieldValue.serverTimestamp(),
    'updated_at': FieldValue.serverTimestamp(),
  };

  ChatRoom toEntity() => ChatRoom(
    id: id,
    participants: participants
        .map(
          (data) =>
              UserEntity(uid: data.uid, name: data.name, email: data.email),
        )
        .toList(),
    participantIds: participantIds,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
