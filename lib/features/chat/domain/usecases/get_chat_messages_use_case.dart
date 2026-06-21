import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/message.dart';
import '../repositories/chat_room_repository.dart';

@lazySingleton
class GetChatMessagesUseCase implements UseCase<List<Message>, String> {
  final ChatRoomRepository _repository;

  GetChatMessagesUseCase(this._repository);

  @override
  Future<Either<Failure, List<Message>>> call(String roomId) =>
      _repository.getMessages(roomId: roomId);
}
