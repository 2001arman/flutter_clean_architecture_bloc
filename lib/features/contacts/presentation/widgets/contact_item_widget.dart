import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../home/presentation/widgets/avatar_widget.dart';

class ContactItemWidget extends StatelessWidget {
  const ContactItemWidget({super.key, required this.user, required this.onTap});
  final UserEntity user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ListTile(
      leading: AvatarWidget(displayName: user.name),
      title: Text(
        user.name,
        style: TextStyle(
          color: colors.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      onTap: onTap,
    );
  }
}
