import 'package:injectable/injectable.dart';

import '../entities/chat_room.dart';
import '../repositories/chat_room_repository.dart';

@lazySingleton
class StreamChatRoomUseCase {
  final ChatRoomRepository _repository;

  StreamChatRoomUseCase(this._repository);

  Stream<List<ChatRoom>> call() => _repository.streamChatRooms();
}
