import 'package:flutter_clean_architecture_bloc/features/contacts/domain/entities/contact_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_state.freezed.dart';

@freezed
sealed class ContactState with _$ContactState {
  const factory ContactState.initial() = ContactInitial;
  const factory ContactState.loading() = ContactLoading;
  const factory ContactState.loaded({required List<ContactEntity> contacts}) =
      ContactLoaded;
  const factory ContactState.failure({required String message}) =
      ContactFailure;
}
