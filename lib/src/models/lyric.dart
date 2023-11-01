import 'package:audioplayers/audioplayers.dart';

import 'lyric_line.dart';

class Lyric {
  /// Title of the media
  final String? title;

  /// Artist of the media
  final String? artist;

  /// Album of the media
  final String? album;

  /// Duration of the media
  final Duration? duration;

  /// Audio source of the media
  final Source? audio;

  /// Lines of the lyric
  final List<LyricLine> lines;

  Lyric({
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.audio,
    required this.lines,
  });
}
