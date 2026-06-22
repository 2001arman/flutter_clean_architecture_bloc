import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/chat_room.dart';

part 'chat_room_event.freezed.dart';

@freezed
sealed class ChatRoomEvent with _$ChatRoomEvent {
  const factory ChatRoomEvent.loadRooms() = ChatRoomLoad;
  const factory ChatRoomEvent.streamRooms() = ChatRoomStream;
  const factory ChatRoomEvent.chatRoomCreated(ChatRoom room) = ChatRoomCreated;
}
