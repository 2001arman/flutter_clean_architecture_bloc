import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/widgets/avatar_widget.dart';

class RoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RoomAppBar({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return AppBar(
      title: Row(
        children: [
          AvatarWidget(size: 40, displayName: name),
          const SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
