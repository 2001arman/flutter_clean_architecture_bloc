import 'package:flutter/material.dart';

import '../../../../core/widgets/skeleton_contact.dart';

class LoadingContactView extends StatelessWidget {
  const LoadingContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) => SkeletonContact(),
      itemCount: 15,
    );
  }
}
