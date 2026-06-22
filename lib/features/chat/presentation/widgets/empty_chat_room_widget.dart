import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyChatRoomWidget extends StatelessWidget {
  const EmptyChatRoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/empty_room.svg',
                  width: MediaQuery.widthOf(context) * 0.7,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Belum ada percakapan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'Mulai obrolan dengan rekan kerja atau tim\nAnda untuk berkolaborasi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
