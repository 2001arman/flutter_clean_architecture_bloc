import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/message.dart';

class MessageModel {
  final String text;
  final String senderId;
  final DateTime sentAt;
  final bool isMe;

  MessageModel({
    required this.text,
    required this.senderId,
    required this.sentAt,
    required this.isMe,
  });

  factory MessageModel.fromJson({
    required Map<String, dynamic> json,
    bool isMe = true,
  }) => MessageModel(
    text: json['text'],
    senderId: json['sender_id'],
    sentAt: (json['sent_at'] as Timestamp).toDate(),
    isMe: isMe,
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'sender_id': senderId,
    'sent_at': Timestamp.now(),
  };

  Message toEntity() =>
      Message(text: text, senderId: senderId, sentAt: sentAt, isMe: isMe);
}
