import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../widgets/contact_item_widget.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({
    super.key,
    required this.contacts,
    required this.isCreatingRoom,
  });
  final List<UserEntity> contacts;
  final bool isCreatingRoom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isCreatingRoom) const LinearProgressIndicator(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) => ContactItemWidget(
              user: contacts[index],
              onTap: () => context.read<ContactBloc>().add(
                ContactEvent.createRoom(contacts[index]),
              ),
            ),
            itemCount: contacts.length,
          ),
        ),
      ],
    );
  }
}
