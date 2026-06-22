import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/extentions/context_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../chat/presentation/bloc/chat_room/chat_room_bloc.dart';
import '../../../chat/presentation/bloc/chat_room/chat_room_event.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../bloc/contact_state.dart';
import '../views/contact_list_view.dart';
import '../views/loading_contact_view.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContactBloc>()..add(ContactLoad()),
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
      body: RefreshIndicator(
        onRefresh: () async => context.read<ContactBloc>().add(ContactLoad()),
        child: BlocConsumer<ContactBloc, ContactState>(
          listener: (context, state) {
            if (state is ContactFailure) {
              context.showErrorSnackBar(state.message);
            } else if (state is ContactRoomCreated) {
              context.push(Routes.chatRoom, extra: state.room);
              context.read<ChatRoomBloc>().add(ChatRoomCreated(state.room));
            }
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const LoadingContactView(),
              loaded: (data) => ContactListView(contacts: data),
              failure: (failure) => Center(child: Text('Error $failure')),
              orElse: () => SizedBox(),
            );
            // return Center(child: Text('Contacts page'));
          },
        ),
      ),
    );
  }
}
