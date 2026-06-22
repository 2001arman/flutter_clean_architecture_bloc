import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../theme/app_theme.dart';

final _random = Random();

const _dummyMessages = [
  "Hi!",
  "Hello 👋",
  "How are you doing today?",
  "Sure, sounds good.",
  "I'll check it and let you know.",
  "Thanks!",
  "That's awesome 😄",
  "Can we meet tomorrow?",
  "I'm on my way.",
  "No problem at all.",
  "Let's do it.",
  "See you soon!",
  "I just pushed the latest changes to GitHub.",
  "The issue has been fixed. Please try again.",
  "This looks much better now.",
  "Could you review my PR when you have time?",
  "Everything is working perfectly now.",
  "I'm still investigating the problem.",
  "I'll send you an update later today.",
  "Great! Thanks for your help.",
];

class SkeletonMessageBubble extends StatelessWidget {
  const SkeletonMessageBubble({super.key, required this.isMe});
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final cs = Theme.of(context).colorScheme;

    final bubbleColor = isMe ? cs.primary : colors.receiverBubbleBg;
    final shimmerColor = isMe
        ? colors.senderReplyBg
        : colors.biometricIconActive;

    final String message =
        _dummyMessages[_random.nextInt(_dummyMessages.length)];

    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(baseColor: shimmerColor),
      child: Padding(
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
                        message,
                        style: TextStyle(color: colors.dateSepText),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Text(
                        "10:10",
                        style: TextStyle(
                          fontSize: 10,
                          color: colors.dateSepText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
