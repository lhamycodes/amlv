import '../../amlv.dart';

class JsonLyricParser extends LyricParser<List<LyricLine>> {
  @override
  Lyric parse(
    List<LyricLine> input, {
    String? title,
    String? artist,
    String? album,
  }) {
    return Lyric(
      title: title,
      artist: artist,
      album: album,
      duration: input.last.time - input.first.time,
      lines: input,
    );
  }
}
