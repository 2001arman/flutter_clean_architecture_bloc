import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/usecases/get_chat_messages_use_case.dart';
import '../../../domain/usecases/send_chat_message_use_case.dart';
import '../../../domain/usecases/stream_chat_message_user_case.dart';
import 'detail_chat_event.dart';
import 'detail_chat_state.dart';

@injectable
class DetailChatBloc extends Bloc<DetailChatEvent, DetailChatState> {
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;
  final StreamChatMessageUserCase _streamChatMessageUserCase;

  DetailChatBloc(
    this._getChatMessagesUseCase,
    this._sendChatMessageUseCase,
    this._streamChatMessageUserCase,
  ) : super(DetailChatInitial()) {
    on<DetailChatGetMessages>(_getMessages);
    on<DetailChatSendMessage>(_sendMessage);
    on<DetailChatStreamMessages>(_streamMessages);
    on<DetailChatOnError>(_onError);
  }

  Future<void> _streamMessages(
    DetailChatStreamMessages event,
    Emitter<DetailChatState> emit,
  ) async {
    emit(DetailChatLoading());

    await emit.forEach<List<Message>>(
      _streamChatMessageUserCase(roomId: event.roomId),
      onData: (messages) {
        return DetailChatMessageLoaded(messages: messages);
      },
      onError: (error, stackTrace) {
        return DetailChatError(error.toString());
      },
    );
  }

  Future<void> _getMessages(
    DetailChatGetMessages event,
    Emitter<DetailChatState> emit,
  ) async {
    emit(DetailChatLoading());

    final data = await _getChatMessagesUseCase.call(event.roomId);

    data.fold(
      (failure) => emit(DetailChatError(failure.message)),
      (messages) => emit(DetailChatMessageLoaded(messages: messages)),
    );
  }

  void _onError(DetailChatOnError event, Emitter<DetailChatState> emit) {
    final currentState = state;
    if (currentState is DetailChatError) {
      emit(DetailChatError(event.message));
    } else if (currentState is DetailChatMessageLoaded) {
      emit(
        DetailChatMessageLoaded(
          error: event.message,
          messages: currentState.messages,
        ),
      );

      emit(
        DetailChatMessageLoaded(error: null, messages: currentState.messages),
      );
    }
  }

  Future<void> _sendMessage(
    DetailChatSendMessage event,
    Emitter<DetailChatState> emit,
  ) async {
    final data = await _sendChatMessageUseCase.call(
      SendChatMessageParam(roomId: event.roomId, text: event.text),
    );

    data.fold(
      (failure) => add(DetailChatOnError(failure.message)),
      (message) {},
    );
  }
}
