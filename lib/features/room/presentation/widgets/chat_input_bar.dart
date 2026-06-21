import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

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
                controller: TextEditingController(),
                maxLines: 3,
                minLines: 1,

                decoration: InputDecoration(
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
                onPressed: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
