import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/domain/entities/contact_entity.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/presentation/bloc/contact_event.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({super.key, required this.contacts});
  final List<ContactEntity> contacts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<ContactBloc>().add(ContactLoad()),
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
                contacts[index].name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          onTap: () {},
        ),
        itemCount: contacts.length,
      ),
    );
  }
}
