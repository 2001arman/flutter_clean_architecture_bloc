import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../entities/chat_room.dart';

abstract class ChatRoomRepository {
  Future<Either<Failure, List<ChatRoom>>> getChatRooms();
  Future<Either<Failure, ChatRoom>> createChatRoom({
    required UserEntity currentUser,
    required UserEntity targetUser,
  });
}
