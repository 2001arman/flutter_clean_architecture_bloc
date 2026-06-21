import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/detail_chat/detail_chat_bloc.dart';
import '../bloc/detail_chat/detail_chat_state.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailChatBloc, DetailChatState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(child: Text(message)),
          messageLoaded: (messages) => ListView.builder(
            itemBuilder: (context, index) =>
                Text('cek messages ${messages[index].text}'),
            itemCount: messages.length,
          ),
        );
      },
    );
  }
}
