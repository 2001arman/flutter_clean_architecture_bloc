import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../chat/domain/entities/chat_room.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../chat/domain/repositories/chat_room_repository.dart';

part 'create_chat_room_use_case.freezed.dart';

@freezed
sealed class CreateChatRoomParam with _$CreateChatRoomParam {
  const factory CreateChatRoomParam({
    required UserEntity currentUser,
    required UserEntity targetUser,
  }) = _CreateChatRoomParam;
}

@lazySingleton
class CreateChatRoomUseCase implements UseCase<ChatRoom, CreateChatRoomParam> {
  final ChatRoomRepository _repository;

  CreateChatRoomUseCase(this._repository);

  @override
  Future<Either<Failure, ChatRoom>> call(CreateChatRoomParam params) =>
      _repository.createChatRoom(
        currentUser: params.currentUser,
        targetUser: params.targetUser,
      );
}
