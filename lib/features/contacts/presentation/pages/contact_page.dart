import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/core/di/injection.dart';
import 'package:flutter_clean_architecture_bloc/core/extentions/context_extension.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/presentation/bloc/contact_event.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/presentation/widgets/contact_list_view.dart';

import '../bloc/contact_bloc.dart';
import '../bloc/contact_state.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContactBloc>()..add(LoadContacts()),
      child: _ContactView(),
    );
  }
}

class _ContactView extends StatelessWidget {
  const _ContactView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactFailure) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return state.when(
            initial: () => SizedBox(),
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (data) => ContactListView(contacts: data),
            failure: (failure) => Center(child: Text('Error $failure')),
          );
          // return Center(child: Text('Contacts page'));
        },
      ),
    );
  }
}
