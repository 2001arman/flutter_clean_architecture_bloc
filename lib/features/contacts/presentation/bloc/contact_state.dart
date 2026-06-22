import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../../../chat/domain/entities/chat_room.dart';

part 'contact_state.freezed.dart';

@freezed
sealed class ContactState with _$ContactState {
  const factory ContactState.initial() = ContactInitial;
  const factory ContactState.loading() = ContactLoading;
  const factory ContactState.loaded({
    required List<UserEntity> contacts,
    @Default(false) bool creatingRoom,
  }) = ContactLoaded;
  const factory ContactState.failure({required String message}) =
      ContactFailure;
  const factory ContactState.roomCreated({required ChatRoom room}) =
      ContactRoomCreated;
}
