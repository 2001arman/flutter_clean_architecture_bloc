import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/chat_room.dart';
import '../bloc/detail_chat/detail_chat_bloc.dart';
import '../bloc/detail_chat/detail_chat_event.dart';
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
        body: MessagesListView(),
      ),
    );
  }
}
