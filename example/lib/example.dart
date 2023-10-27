// ignore_for_file: avoid_print

import 'package:amlv/amlv.dart';
import 'const.dart';

Future<void> main() async {
  LyricParser parser = SrtLyricParser();
  Lyric lyric = await parser.parse(
    '''
    1
    00:00:00,498 --> 00:00:02,827
    - Here's what I love most
    about food and diet.

    2
    00:00:02,827 --> 00:00:06,383
    We all eat several times a day,
    and we're totally in charge

    3
    00:00:06,383 --> 00:00:09,427
    of what goes on our plate
    and what stays off.''',
    UrlSource(""),
  );

  for (var line in lyric.lines) {
    print("[${line.time}]: ${line.content}");
  }

  LyricParser lrcParser = LrcLyricParser();
  Lyric lrcLyric = await lrcParser.parse(lrcLyrics, UrlSource(lrcUrlSource));

  print(lrcLyric.album);
  for (var line in lrcLyric.lines) {
    print("[${line.time}]: ${line.content}");
  }
}
