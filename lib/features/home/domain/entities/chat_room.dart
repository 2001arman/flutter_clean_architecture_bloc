import 'package:flutter_clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'message.dart';

part 'chat_room.freezed.dart';

@freezed
sealed class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required List<UserEntity> participants,
    required List<String> participantIds,
    required DateTime createdAt,
    required DateTime updatedAt,
    Message? lastMessage,
  }) = _ChatRoom;
}
