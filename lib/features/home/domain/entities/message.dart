import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
sealed class Message with _$Message {
  const factory Message({
    required String text,
    required String senderId,
    required DateTime sentAt,
    required bool isRead,
  }) = _Message;
}
