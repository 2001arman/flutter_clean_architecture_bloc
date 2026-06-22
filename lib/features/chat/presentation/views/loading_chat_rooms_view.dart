import 'package:flutter/material.dart';

import '../../../../core/widgets/skeleton_chat_room.dart';

class LoadingChatRoomsView extends StatelessWidget {
  const LoadingChatRoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) => SkeletonChatRoom(),
      itemCount: 15,
    );
  }
}
