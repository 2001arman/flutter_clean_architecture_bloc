import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/message.dart';

class MessageModel {
  final String text;
  final String senderId;
  final DateTime sentAt;
  final bool isRead;

  MessageModel({
    required this.text,
    required this.senderId,
    required this.sentAt,
    required this.isRead,
  });

  factory MessageModel.fromJson({required Map<String, dynamic> json}) =>
      MessageModel(
        text: json['text'],
        senderId: json['sender_id'],
        sentAt: (json['sent_at'] as Timestamp).toDate(),
        isRead: json['is_read'] ?? false,
      );

  Message toEntity() =>
      Message(text: text, senderId: senderId, sentAt: sentAt, isRead: isRead);
}
