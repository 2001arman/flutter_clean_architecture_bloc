import 'package:flutter/material.dart';

import '../../domain/entities/chat_room.dart';

class ChatRoomsListView extends StatelessWidget {
  final List<ChatRoom> rooms;
  const ChatRoomsListView({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemBuilder: (context, index) => ListTile(
          title: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person_2_outlined, color: Colors.black),
              ),
              Text(
                rooms[index].participants.last.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          onTap: () {},
        ),
        itemCount: rooms.length,
      ),
    );
  }
}
