import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/entities/user_entity.dart';

part 'contact_event.freezed.dart';

@freezed
sealed class ContactEvent with _$ContactEvent {
  const factory ContactEvent.loadContacts() = ContactLoad;
  const factory ContactEvent.createRoom(UserEntity targetUser) =
      ContactCreateRoom;
}
