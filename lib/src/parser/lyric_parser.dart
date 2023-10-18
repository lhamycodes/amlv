import '../../amlv.dart' show Lyric;

abstract class LyricParser<T> {
  Future<Lyric?> parse(T input);
}
