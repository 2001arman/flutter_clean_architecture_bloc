import 'package:flutter/material.dart';

import '../../../../core/extentions/date_extention.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/chat_room.dart';
import 'avatar_widget.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key, required this.room, required this.onTap});
  final ChatRoom room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ListTile(
      leading: AvatarWidget(displayName: room.participants.last.name),
      title: Row(
        children: [
          Expanded(
            child: Text(
              room.participants.last.name,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
