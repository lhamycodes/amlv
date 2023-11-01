import 'package:flutter/material.dart';

/// A button that is used in the player.
class PlayerIconButton extends StatelessWidget {
  /// The icon to be displayed.
  final IconData icon;

  /// The function to be called when the button is tapped.
  /// Can be null.
  final Function()? onTap;

  /// The color of the icon.
  /// Defaults to Color(0xFF000000).
  final Color color;

  /// The size of the icon
  /// Defaults to 30.
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
