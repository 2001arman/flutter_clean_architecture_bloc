import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extentions/context_extension.dart';
import '../bloc/detail_chat/detail_chat_bloc.dart';
import '../bloc/detail_chat/detail_chat_state.dart';
import '../widgets/message_bubble.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailChatBloc, DetailChatState>(
      listener: (context, state) {
        if (state is DetailChatError) {
          context.showErrorSnackBar(state.message);
        } else if (state is DetailChatMessageLoaded && state.error != null) {
          context.showErrorSnackBar(state.error!);
        }
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(child: Text(message)),
          messageLoaded: (messages, error) => ListView.builder(
            padding: .symmetric(horizontal: 12, vertical: 16),
            reverse: true,
            itemBuilder: (context, index) =>
                MessageBubble(message: messages[index]),
            itemCount: messages.length,
          ),
        );
      },
    );
  }
}
