import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_room.dart';
import '../bloc/chat_room/chat_room_bloc.dart';
import '../bloc/chat_room/chat_room_event.dart';
import 'chat_item_widget.dart';

class ChatRoomsListView extends StatelessWidget {
  final List<ChatRoom> rooms;
  const ChatRoomsListView({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ChatRoomBloc>().add(ChatRoomEvent.loadRooms()),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) =>
            ChatItemWidget(room: rooms[index], onTap: () {}),
        itemCount: rooms.length,
      ),
    );
  }
}
