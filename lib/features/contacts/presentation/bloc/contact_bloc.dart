import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/usecase/load_current_user_use_case.dart';
import '../../../chat/domain/usecases/create_chat_room_use_case.dart';
import '../../domain/repositories/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

@injectable
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _repository;
  final CreateChatRoomUseCase _createChatRoomUseCase;
  final LoadCurrentUserUseCase _loadCurrentUserUseCase;

  ContactBloc(
    this._repository,
    this._createChatRoomUseCase,
    this._loadCurrentUserUseCase,
  ) : super(ContactInitial()) {
    on<ContactLoad>(_onLoadContacts);
    on<ContactCreateRoom>(_createRoom);
  }

  void _onLoadContacts(ContactEvent event, Emitter<ContactState> emit) async {
    emit(ContactLoading());

    final result = await _repository.getContactData();
    result.fold(
      (failure) => emit(ContactFailure(message: failure.message)),
      (data) => emit(ContactLoaded(contacts: data)),
    );
  }

  void _createRoom(ContactCreateRoom event, Emitter<ContactState> emit) async {
    final currentState = state;

    if (currentState is! ContactLoaded) return;
    emit(ContactLoaded(contacts: currentState.contacts, creatingRoom: true));

    final result = await _loadCurrentUserUseCase(NoParams());

    UserEntity? currentUser;

    result.fold((failure) {}, (user) {
      currentUser = user;
    });

    if (currentUser == null) return;

    final chatResult = await _createChatRoomUseCase(
      CreateChatRoomParam(
        currentUser: currentUser!,
        targetUser: event.targetUser,
      ),
    );

    chatResult.fold(
      (l) {
        return;
      },
      (room) {
        emit(ContactRoomCreated(room: room));

        emit(
          ContactLoaded(contacts: currentState.contacts, creatingRoom: false),
        );
      },
    );
  }
}
