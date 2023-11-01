import '../../amlv.dart';

/// Parser for Json input data.
class JsonLyricParser extends LyricParser<List<Map<String, dynamic>>> {
  @override
  Lyric parse(
    List<Map<String, dynamic>> input,
    Source audio, {
    String? title,
    String? artist,
    String? album,
  }) {
    List<LyricLine> lines = generateLyricLineFromList(input);

    return Lyric(
      title: title,
      artist: artist,
      album: album,
      duration: lines.last.time - lines.first.time,
      lines: lines,
      audio: audio,
    );
  }

  /// Generate a list of [LyricLine] from a list of [Map<String, dynamic>].
  List<LyricLine> generateLyricLineFromList(List<Map<String, dynamic>> input) {
    List<LyricLine> ll = [];
    for (final line in input) {
      /// Check if each line in input contains the required keys (time, content)
      assert(line.containsKey('time'));
      assert(line.containsKey('content'));

      ll.add(LyricLine(
        time: Duration(milliseconds: line['time']),
        content: line['content'],
      ));
    }
    return ll;
  }
}
