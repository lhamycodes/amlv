import 'package:flutter/material.dart';

import '../../../amlv.dart';

/// Shows the title and artist of the current playing media.
class LyricViewerTitle extends StatelessWidget {
  /// The [Lyric] object to be displayed.
  final Lyric lyric;

  /// The color of the title.
  final Color? titleColor;

  /// The color of the artist.
  final Color? subtitleColor;

  const LyricViewerTitle({
    super.key,
    required this.lyric,
    required this.titleColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lyric.title ?? "Unknown",
          style: TextStyle(
            fontSize: 18,
            color: titleColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          lyric.artist ?? "",
          style: TextStyle(fontSize: 16, color: subtitleColor),
        )
      ],
    );
  }
}
