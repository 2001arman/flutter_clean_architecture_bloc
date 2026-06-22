import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
          messageLoaded: (messages, error) => messages.isEmpty
              ? _EmptyChatMessageWidget()
              : ListView.builder(
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

class _EmptyChatMessageWidget extends StatelessWidget {
  const _EmptyChatMessageWidget();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/empty_chat.svg',
            width: MediaQuery.widthOf(context) * 0.6,
          ),
          const SizedBox(height: 32),
          const Text(
            'Belum ada percakapan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Mulai obrolan dengan rekan kerja atau tim\nAnda untuk berkolaborasi.',
            textAlign: TextAlign.center,
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
