import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../amlv.dart';

/// A widget that displays a list of [LyricLine].
class LyricLinesBuilder extends StatelessWidget {
  /// The [AutoScrollController] instance
  /// which helps with scrolling to [LyricLine].
  final AutoScrollController controller;

  /// The index of the current [LyricLine].
  final int currentLyricLine;

  /// The list of [LyricLine] to be displayed.
  final List<LyricLine>? lines;

  /// The callback for when the [LyricLine] is changed.
  final Function(int, String) onLineChanged;

  /// The color of the active [LyricLine].
  final Color? activeColor;

  /// The color of the inactive [LyricLine].
  final Color? inactiveColor;

  const LyricLinesBuilder({
    super.key,
    required this.controller,
    required this.currentLyricLine,
    required this.lines,
    required this.onLineChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.white],
            stops: [0.0, 1.0], // 50% transparent, 50% white
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: SingleChildScrollView(
          controller: controller,
          padding: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: generateLyricItems(lines),
          ),
        ),
      ),
    );
  }

  /// Generate a list of [Widget] from a list of [LyricLine].
  List<Widget> generateLyricItems(List<LyricLine>? lines) {
    List<Widget> items = [];
    for (var i = 0; i < lines!.length; i++) {
      items.add(AutoScrollTag(
        controller: controller,
        index: i,
        key: ValueKey(i),
        child: GestureDetector(
          onTap: () => onLineChanged(i, "seeker"),
          child: Text(
            lines[i].content,
            style: TextStyle(
              color: currentLyricLine == i ? activeColor : inactiveColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
      ));
      if (i != lines.length - 1) items.add(verticalSpace(15));
    }
    return items;
  }
}
