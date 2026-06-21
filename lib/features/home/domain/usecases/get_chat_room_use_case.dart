import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/chat_room.dart';
import '../repositories/chat_room_repository.dart';

@lazySingleton
class GetChatRoomUseCase implements UseCase<List<ChatRoom>, NoParams> {
  final ChatRoomRepository _repository;

  GetChatRoomUseCase(this._repository);

  @override
  Future<Either<Failure, List<ChatRoom>>> call(NoParams params) =>
      _repository.getChatRooms();
}
