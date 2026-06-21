import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/message.dart';

part 'detail_chat_state.freezed.dart';

@freezed
sealed class DetailChatState with _$DetailChatState {
  const factory DetailChatState.initial() = DetailChatInitial;
  const factory DetailChatState.messageLoaded({
    required List<Message> messages,
    String? error,
  }) = DetailChatMessageLoaded;

  const factory DetailChatState.loading() = DetailChatLoading;
  const factory DetailChatState.error(String message) = DetailChatError;
}
