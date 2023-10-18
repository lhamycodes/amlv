import '../../amlv.dart';

class JsonLyricParser extends LyricParser<List<LyricLine>> {
  @override
  Future<Lyric?> parse(
    List<LyricLine> input, {
    String? title,
    String? artist,
    String? album,
  }) async {
    return Lyric(
      title: title,
      artist: artist,
      album: album,
      duration: input.last.time - input.first.time,
      lines: input,
    );
  }
}
