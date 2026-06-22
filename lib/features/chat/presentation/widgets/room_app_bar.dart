import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/user_cubit.dart';
import '../../domain/entities/chat_room.dart';
import 'avatar_widget.dart';
import 'room_name_widget.dart';

class RoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RoomAppBar({super.key, required this.room});

  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return state.maybeMap(
                loaded: (loaded) {
                  String roomName = room.participants
                      .firstWhere((data) => data != loaded.user)
                      .name;
                  return AvatarWidget(size: 40, displayName: roomName);
                },
                orElse: () => const SizedBox(),
              );
            },
          ),
          const SizedBox(width: 12),
          RoomNameWidget(room: room),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
