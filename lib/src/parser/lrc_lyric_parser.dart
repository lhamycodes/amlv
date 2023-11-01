import 'package:lyrics_parser/lyrics_parser.dart';
import 'package:lyrics_parser/src/models.dart';

import '../../amlv.dart';

/// Parser for LRC files or LRC formatted strings.
class LrcLyricParser extends LyricParser<String> {
  @override
  Future<Lyric> parse(String input, Source audio) async {
    final parser = LyricsParser(input);
    final result = await parser.parse();

    return Lyric(
      title: result.title,
      artist: result.artist,
      album: result.album,
      duration: Duration(milliseconds: result.millisecondLength!.toInt()),
      lines: generateLyricLineFromList(result.lyricList),
      audio: audio,
    );
  }

  List<LyricLine> generateLyricLineFromList(List<LcrLyric> lyricList) {
    List<LyricLine> ll = [];
    for (final lyric in lyricList) {
      ll.add(LyricLine(
        time: Duration(milliseconds: lyric.startTimeMillisecond!.toInt()),
        content: lyric.content,
      ));
    }
    return ll;
  }
}
