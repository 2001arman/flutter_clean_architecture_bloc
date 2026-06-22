import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonChatRoom extends StatelessWidget {
  const SkeletonChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Text(
            "AB",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Text("Sekeleton Chat Room Text")),
            Text("10:20", style: TextStyle(fontSize: 10)),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                'No messages yet',
                style: TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
