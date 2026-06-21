import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../bloc/detail_chat/detail_chat_bloc.dart';
import '../bloc/detail_chat/detail_chat_event.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key, required this.roomId});
  final String roomId;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    context.read<DetailChatBloc>().add(
      DetailChatSendMessage(
        roomId: widget.roomId,
        text: _inputController.text.trim(),
      ),
    );

    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      color: colors.inputBg,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _inputController,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  fillColor: colors.containerBg,
                  contentPadding: const .all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: cs.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: cs.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: cs.primary),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),

            Container(
              width: 46,
              height: 46,
              margin: .only(left: 12),
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: Icon(Icons.send, color: cs.onPrimary),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
