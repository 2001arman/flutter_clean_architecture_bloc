import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.displayName,
    this.size = 48,
    this.padding = 10,
  });

  final String? displayName;
  final double size, padding;

  String get _initial {
    if (displayName == null || displayName!.trim().isEmpty) return '?';

    final words = displayName!
        .replaceAll("_", " ")
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.length == 1) {
      return words.first.characters.first.toUpperCase();
    }

    return (words[0].characters.first + words[1].characters.first)
        .toUpperCase();
  }

  Color get _backgroundColor {
    const colors = [
      Color(0xFF8E44AD), // purple
      Color(0xFF2980B9), // blue
      Color(0xFF27AE60), // green
      Color(0xFFE67E22), // orange
      Color(0xFFC0392B), // red
      Color(0xFF16A085), // teal
    ];

    final seed = displayName?.hashCode ?? 0;
    return colors[seed.abs() % colors.length];
  }

  Widget _avatarPlaceholder() {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _backgroundColor,
      ),
      child: Text(
        _initial,
        style: TextStyle(
          fontSize: _initial.length > 1 ? size / 3 : size / 2,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _avatarPlaceholder();
  }
}
