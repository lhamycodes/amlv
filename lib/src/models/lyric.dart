import 'lyric_line.dart';

class Lyric {
  final String? title;
  final String? artist;
  final String? album;
  final Duration? duration;
  final List<LyricLine> lines;

  Lyric({
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.lines,
  });
}
