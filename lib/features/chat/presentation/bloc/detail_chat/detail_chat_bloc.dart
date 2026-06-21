import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_chat_messages_use_case.dart';
import 'detail_chat_event.dart';
import 'detail_chat_state.dart';

@injectable
class DetailChatBloc extends Bloc<DetailChatEvent, DetailChatState> {
  final GetChatMessagesUseCase _getChatMessagesUseCase;

  DetailChatBloc(this._getChatMessagesUseCase) : super(DetailChatInitial()) {
    on<DetailChatGetMessages>(_getMessages);
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
}
