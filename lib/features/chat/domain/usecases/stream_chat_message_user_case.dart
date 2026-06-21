import 'package:injectable/injectable.dart';

import '../entities/message.dart';
import '../repositories/chat_room_repository.dart';

@lazySingleton
class StreamChatMessageUserCase {
  final ChatRoomRepository _repository;

  StreamChatMessageUserCase(this._repository);

  Stream<List<Message>> call({required String roomId}) {
    return _repository.streamMessage(roomId: roomId);
  }
}
