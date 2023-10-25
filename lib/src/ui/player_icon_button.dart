import 'package:flutter/material.dart';

class PlayerIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final Color color;
  final double size;

  const PlayerIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.color = const Color(0xFF000000),
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: color, size: size),
    );
  }
}
