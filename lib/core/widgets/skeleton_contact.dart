import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonContact extends StatelessWidget {
  const SkeletonContact({super.key});

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
        title: Text(
          "Skeleton contact",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        onTap: () {},
      ),
    );
  }
}
