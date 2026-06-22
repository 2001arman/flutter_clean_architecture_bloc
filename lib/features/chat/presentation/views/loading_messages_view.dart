import 'package:flutter/material.dart';

import '../../../../core/widgets/skeleton_message_bubble.dart';

class LoadingMessagesView extends StatelessWidget {
  const LoadingMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: .symmetric(horizontal: 12, vertical: 16),
      reverse: true,
      itemBuilder: (context, index) =>
          SkeletonMessageBubble(isMe: index % 2 == 0),
      itemCount: 15,
    );
  }
}
