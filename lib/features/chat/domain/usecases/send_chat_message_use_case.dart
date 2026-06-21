import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/message.dart';
import '../repositories/chat_room_repository.dart';

part 'send_chat_message_use_case.freezed.dart';

@freezed
sealed class SendChatMessageParam with _$SendChatMessageParam {
  const factory SendChatMessageParam({
    required String roomId,
    required String text,
  }) = _SendChatMessageParam;
}

@lazySingleton
class SendChatMessageUseCase implements UseCase<Message, SendChatMessageParam> {
  final ChatRoomRepository _repository;

  SendChatMessageUseCase(this._repository);

  @override
  Future<Either<Failure, Message>> call(SendChatMessageParam params) =>
      _repository.sendMessage(roomId: params.roomId, text: params.text);
}
