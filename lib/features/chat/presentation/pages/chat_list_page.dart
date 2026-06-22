import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extentions/context_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/user_cubit.dart';
import '../bloc/chat_room/chat_room_bloc.dart';
import '../bloc/chat_room/chat_room_event.dart';
import '../bloc/chat_room/chat_room_state.dart';
import '../views/chat_rooms_list_view.dart';
import '../views/loading_chat_rooms_view.dart';
import '../widgets/empty_chat_room_widget.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        state.mapOrNull(
          error: (failure) => context.showErrorSnackBar(failure.message),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) => state.maybeWhen(
              orElse: () => Text("Welcome"),
              loaded: (user) => Text("Welcome ${user.name}"),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.read<UserCubit>().logout(),
              icon: Icon(Icons.logout),
              color: Colors.red,
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async =>
              context.read<ChatRoomBloc>().add(ChatRoomEvent.loadRooms()),
          child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                loading: () => const LoadingChatRoomsView(),
                loaded: (rooms) => rooms.isEmpty
                    ? EmptyChatRoomWidget()
                    : ChatRoomsListView(rooms: rooms),
                error: (error) => Center(child: Text(error)),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(Routes.contact),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
