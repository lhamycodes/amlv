import 'package:audioplayers/audioplayers.dart';

import 'lyric_line.dart';

class Lyric {
  final String? title;
  final String? artist;
  final String? album;
  final Duration? duration;
  final Source? audio;
  final List<LyricLine> lines;

  Lyric({
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.audio,
    required this.lines,
  });

  bool get canShowTitle => title != null || artist != null;
}
