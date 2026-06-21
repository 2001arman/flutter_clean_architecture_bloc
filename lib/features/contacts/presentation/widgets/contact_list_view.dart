import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../../../home/presentation/bloc/chat_room/chat_room_bloc.dart';
import '../../../home/presentation/bloc/chat_room/chat_room_event.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import 'contact_item_widget.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({super.key, required this.contacts});
  final List<UserEntity> contacts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<ContactBloc>().add(ContactLoad()),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) => ContactItemWidget(
          user: contacts[index],
          onTap: () => context.read<ChatRoomBloc>().add(
            ChatRoomEvent.createRoom(contacts[index]),
          ),
        ),
        itemCount: contacts.length,
      ),
    );
  }
}
