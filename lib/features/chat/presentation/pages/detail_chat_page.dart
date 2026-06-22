import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/extentions/context_extension.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/chat_room.dart';
import '../bloc/detail_chat/detail_chat_bloc.dart';
import '../bloc/detail_chat/detail_chat_event.dart';
import '../bloc/detail_chat/detail_chat_state.dart';
import '../views/loading_messages_view.dart';
import '../views/messages_list_view.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/room_app_bar.dart';

class DetailChatPage extends StatelessWidget {
  const DetailChatPage({super.key, required this.room});
  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return BlocProvider(
      create: (context) =>
          getIt<DetailChatBloc>()..add(DetailChatEvent.streamMessages(room.id)),
      child: Scaffold(
        backgroundColor: colors.chatRoomBg,
        resizeToAvoidBottomInset: true,
        appBar: RoomAppBar(room: room),
        bottomNavigationBar: ChatInputBar(roomId: room.id),
        body: BlocConsumer<DetailChatBloc, DetailChatState>(
          listener: (context, state) {
            if (state is DetailChatError) {
              context.showErrorSnackBar(state.message);
            } else if (state is DetailChatMessageLoaded &&
                state.error != null) {
              context.showErrorSnackBar(state.error!);
            }
          },
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const LoadingMessagesView(),
              error: (message) => Center(child: Text(message)),
              messageLoaded: (messages, error) => messages.isEmpty
                  ? _EmptyChatMessageWidget()
                  : MessagesListView(messages: messages),
            );
          },
        ),
      ),
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
            'No messages yet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Send the first message to start the conversation.',
            textAlign: TextAlign.center,
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
