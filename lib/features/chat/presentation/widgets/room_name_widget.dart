import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/bloc/user_cubit.dart';
import '../../domain/entities/chat_room.dart';

class RoomNameWidget extends StatelessWidget {
  final ChatRoom room;
  const RoomNameWidget({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.maybeMap(
          loaded: (loaded) {
            String roomName = room.participants
                .firstWhere((data) => data != loaded.user)
                .name;
            return Text(
              roomName,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }
}
