import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget body;
  final Color color1;
  final Color color2;

  const AnimatedBackground({
    super.key,
    required this.body,
    required this.color1,
    required this.color2,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        "color1",
        ColorTween(begin: widget.color1, end: widget.color2),
        duration: Duration(seconds: 3),
      )
      ..tween(
        "color2",
        ColorTween(begin: widget.color2, end: widget.color1),
        duration: Duration(seconds: 3),
      );

    return MirrorAnimationBuilder<Movie>(
      tween: tween,
      duration: tween.duration,
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [value.get("color1"), value.get("color2")],
            ),
          ),
          child: child,
        );
      },
      curve: Curves.easeIn,
      child: widget.body,
    );
  }
}
