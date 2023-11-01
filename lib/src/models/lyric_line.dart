class LyricLine {
  /// Duration at which the line should be displayed
  final Duration time;

  /// Content of the line
  final String content;

  LyricLine({
    required this.time,
    required this.content,
  });
}
