import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../home/domain/entities/chat_room.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/room_app_bar.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key, required this.room});
  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.chatRoomBg,
      resizeToAvoidBottomInset: true,
      appBar: RoomAppBar(name: room.participants.last.name),
      bottomNavigationBar: ChatInputBar(),
    );
  }
}
