import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/chat_room.dart';

part 'chat_room_state.freezed.dart';

@freezed
sealed class ChatRoomState with _$ChatRoomState {
  const factory ChatRoomState.initial() = ChatRoomInitial;
  const factory ChatRoomState.loading() = ChatRoomLoading;
  const factory ChatRoomState.loaded({required List<ChatRoom> rooms}) =
      ChatRoomLoaded;
  const factory ChatRoomState.error(String message) = ChatRoomError;
}
