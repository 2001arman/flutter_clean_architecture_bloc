import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/chat_room.dart';
import '../../../domain/usecases/get_chat_room_use_case.dart';
import '../../../domain/usecases/stream_chat_room_use_case.dart';
import 'chat_room_event.dart';
import 'chat_room_state.dart';

@injectable
class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final GetChatRoomUseCase _getChatRoomUseCase;
  final StreamChatRoomUseCase _streamChatRoomUseCase;

  ChatRoomBloc(this._getChatRoomUseCase, this._streamChatRoomUseCase)
    : super(ChatRoomInitial()) {
    on<ChatRoomLoad>(_loadChatRooms);
    // on<ChatRoomCreated>(_addRoom);
    on<ChatRoomStream>(_streamChatRooms);
  }

  Future<void> _streamChatRooms(
    ChatRoomStream event,
    Emitter<ChatRoomState> emit,
  ) async {
    emit(ChatRoomState.loading());

    await emit.forEach<List<ChatRoom>>(
      _streamChatRoomUseCase.call(),
      onData: (data) => ChatRoomState.loaded(rooms: data),
      onError: (error, stackTrace) => ChatRoomState.error(error.toString()),
    );
  }

  void _loadChatRooms(ChatRoomEvent event, Emitter<ChatRoomState> emit) async {
    emit(ChatRoomState.loading());

    final data = await _getChatRoomUseCase.call(NoParams());
    data.fold(
      (fail) => emit(ChatRoomState.error(fail.message)),
      (rooms) => emit(ChatRoomState.loaded(rooms: rooms)),
    );
  }

  // void _addRoom(ChatRoomCreated event, Emitter<ChatRoomState> emit) async {
  //   final currentState = state;
  //   if (currentState is ChatRoomLoaded) {
  //     final isDuplicate = currentState.rooms.contains(event.room);
  //     if (!isDuplicate) {
  //       final rooms = [...currentState.rooms, event.room];
  //       emit(ChatRoomState.loaded(rooms: rooms));
  //     }
  //   }
  // }
}
