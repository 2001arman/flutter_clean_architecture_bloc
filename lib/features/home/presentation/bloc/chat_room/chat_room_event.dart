import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../auth/domain/entities/user_entity.dart';

part 'chat_room_event.freezed.dart';

@freezed
sealed class ChatRoomEvent with _$ChatRoomEvent {
  const factory ChatRoomEvent.loadRooms() = ChatRoomLoad;
  const factory ChatRoomEvent.createRoom(UserEntity targetUser) =
      ChatRoomCreate;
}
