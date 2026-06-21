import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_chat_messages_use_case.dart';
import '../../../domain/usecases/send_chat_message_use_case.dart';
import 'detail_chat_event.dart';
import 'detail_chat_state.dart';

@injectable
class DetailChatBloc extends Bloc<DetailChatEvent, DetailChatState> {
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;

  DetailChatBloc(this._getChatMessagesUseCase, this._sendChatMessageUseCase)
    : super(DetailChatInitial()) {
    on<DetailChatGetMessages>(_getMessages);
    on<DetailChatSendMessage>(_sendMessage);
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

  Future<void> _sendMessage(
    DetailChatSendMessage event,
    Emitter<DetailChatState> emit,
  ) async {
    final currentState = state;
    final data = await _sendChatMessageUseCase.call(
      SendChatMessageParam(roomId: event.roomId, text: event.text),
    );

    data.fold(
      (failure) {
        if (currentState is DetailChatError) {
          emit(DetailChatError(failure.message));
        } else if (currentState is DetailChatMessageLoaded) {
          emit(
            DetailChatMessageLoaded(
              error: failure.message,
              messages: currentState.messages,
            ),
          );

          emit(
            DetailChatMessageLoaded(
              error: null,
              messages: currentState.messages,
            ),
          );
        }
      },
      (message) {
        if (currentState is DetailChatMessageLoaded) {
          emit(
            DetailChatMessageLoaded(
              error: null,
              messages: [message, ...currentState.messages],
            ),
          );
        }
      },
    );
  }
}
