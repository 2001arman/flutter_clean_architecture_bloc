import 'package:flutter/material.dart';

import '../../domain/entities/message.dart';
import '../widgets/message_bubble.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key, required this.messages});
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: .symmetric(horizontal: 12, vertical: 16),
      reverse: true,
      itemBuilder: (context, index) => MessageBubble(message: messages[index]),
      itemCount: messages.length,
    );
  }
}
