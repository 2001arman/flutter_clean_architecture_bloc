import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../../auth/domain/usecase/load_current_user_use_case.dart';
import '../../../domain/usecases/create_chat_room_use_case.dart';
import '../../../domain/usecases/get_chat_room_use_case.dart';
import 'chat_room_event.dart';
import 'chat_room_state.dart';

@injectable
class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final GetChatRoomUseCase _getChatRoomUseCase;
  final LoadCurrentUserUseCase _loadCurrentUserUseCase;
  final CreateChatRoomUseCase _createChatRoomUseCase;

  ChatRoomBloc(
    this._getChatRoomUseCase,
    this._loadCurrentUserUseCase,
    this._createChatRoomUseCase,
  ) : super(ChatRoomInitial()) {
    on<ChatRoomLoad>(_loadChatRooms);
    on<ChatRoomCreate>(_createRoom);
  }

  void _loadChatRooms(ChatRoomEvent event, Emitter<ChatRoomState> emit) async {
    emit(ChatRoomState.loading());

    final data = await _getChatRoomUseCase.call(NoParams());
    data.fold(
      (fail) => emit(ChatRoomState.error(fail.message)),
      (rooms) => emit(ChatRoomState.loaded(rooms: rooms)),
    );
  }

  void _createRoom(ChatRoomCreate event, Emitter<ChatRoomState> emit) async {
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
        final currentState = state;
        print('cek currentState $room $currentState');
        if (currentState is ChatRoomLoaded) {
          final rooms = [...currentState.rooms, room];
          emit(ChatRoomState.loaded(rooms: rooms));
        }
      },
    );
  }
}
