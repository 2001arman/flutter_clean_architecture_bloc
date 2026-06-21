import 'package:flutter/material.dart';

import '../../../../core/extentions/date_extention.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final Message message;

  bool get isMe => message.isMe;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final cs = Theme.of(context).colorScheme;

    final bubbleColor = isMe ? cs.primary : colors.receiverBubbleBg;
    final textColor = isMe ? Colors.white : colors.receiverBubbleText;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 8),
                  bottomRight: Radius.circular(isMe ? 8 : 16),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Text(
                      message.text,
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Text(
                      message.sentAt.hourFormat,
                      style: TextStyle(
                        fontSize: 10,
                        color: textColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
