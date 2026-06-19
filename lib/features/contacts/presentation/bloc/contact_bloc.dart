import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/contacts/domain/repositories/contact_repository.dart';
import 'package:injectable/injectable.dart';

import 'contact_event.dart';
import 'contact_state.dart';

@injectable
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _repository;

  ContactBloc(this._repository) : super(ContactInitial()) {
    on<LoadContacts>(_onLoadContacts);
  }

  void _onLoadContacts(ContactEvent event, Emitter<ContactState> emit) async {
    emit(ContactLoading());

    final result = await _repository.getContactData();
    result.fold(
      (failure) => emit(ContactFailure(message: failure.message)),
      (data) => emit(ContactLoaded(contacts: data)),
    );
  }
}
