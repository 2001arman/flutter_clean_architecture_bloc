import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_chat_event.freezed.dart';

@freezed
sealed class DetailChatEvent with _$DetailChatEvent {
  const factory DetailChatEvent.getMessages(String roomId) =
      DetailChatGetMessages;
  const factory DetailChatEvent.sendMessage({
    required String roomId,
    required String text,
  }) = DetailChatSendMessage;
}
