import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extentions/date_extention.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/bloc/user_cubit.dart';
import '../../domain/entities/chat_room.dart';
import 'avatar_widget.dart';
import 'room_name_widget.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key, required this.room, required this.onTap});
  final ChatRoom room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ListTile(
      leading: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.maybeMap(
            loaded: (loaded) {
              String roomName = room.participants
                  .firstWhere((data) => data != loaded.user)
                  .name;
              return AvatarWidget(displayName: roomName);
            },
            orElse: () => const SizedBox(),
          );
        },
      ),
      title: Row(
        children: [
          Expanded(child: RoomNameWidget(room: room)),
          Text(
            room.updatedAt.format(),
            style: TextStyle(color: colors.secondaryText, fontSize: 10),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              room.lastMessage?.text ?? 'No messages yet',
              style: TextStyle(color: colors.onSurfaceSecondary, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
