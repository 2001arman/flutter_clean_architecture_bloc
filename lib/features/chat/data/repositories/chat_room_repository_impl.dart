import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_room_repository.dart';
import '../datasources/chat_room_datasource.dart';

@LazySingleton(as: ChatRoomRepository)
class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final ChatRoomDatasource _datasource;

  ChatRoomRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ChatRoom>>> getChatRooms() async =>
      handleExceptionAsync(() async {
        final data = await _datasource.getChatRooms();
        return data.map((room) => room.toEntity()).toList();
      });

  @override
  Future<Either<Failure, ChatRoom>> createChatRoom({
    required UserEntity currentUser,
    required UserEntity targetUser,
  }) async => handleExceptionAsync(() async {
    final data = await _datasource.createChatRoom(
      currentUser: UserModel.fromEntity(currentUser),
      targetUser: UserModel.fromEntity(targetUser),
    );

    return data.toEntity();
  });

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required String roomId,
  }) => handleExceptionAsync(() async {
    final data = await _datasource.getMessages(roomId);
    return data.map((message) => message.toEntity()).toList();
  });

  @override
  Future<Either<Failure, Message>> sendMessage({
    required String roomId,
    required String text,
  }) => handleExceptionAsync(() async {
    final message = await _datasource.sendMessage(roomId: roomId, text: text);
    return message.toEntity();
  });
}
