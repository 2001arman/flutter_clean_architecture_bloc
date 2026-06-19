import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_entity.freezed.dart';

@freezed
sealed class ContactEntity with _$ContactEntity {
  const factory ContactEntity({required String userId, required String name}) =
      _ContactEntity;
}
