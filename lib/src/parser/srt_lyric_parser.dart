import 'package:srt_parser_2/srt_parser_2.dart';

import '../../amlv.dart';

class SrtLyricParser extends LyricParser<String> {
  @override
  Future<Lyric?> parse(
    String input, {
    String? title,
    String? artist,
    String? album,
  }) async {
    List<Subtitle> subtitles = parseSrt(input);

    Duration duration = Duration(
      milliseconds: subtitles.last.range.end - subtitles.first.range.begin,
    );

    return Lyric(
      title: title,
      artist: artist,
      album: album,
      duration: duration,
      lines: [],
    );
  }

  List<LyricLine> generateLyricLineFromList(List<Subtitle> lyricList) {
    List<LyricLine> ll = [];
    for (final lines in lyricList) {
      List<String> parsedLines = [];
      for (final line in lines.rawLines) {
        parsedLines.add(line);
      }
      ll.add(LyricLine(
        time: Duration(milliseconds: lines.range.begin),
        content: parsedLines.join('\n'),
      ));
    }
    return ll;
  }
}
