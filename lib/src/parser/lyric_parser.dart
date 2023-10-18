import 'dart:async';

import '../../amlv.dart' show Lyric;

abstract class LyricParser<T> {
  FutureOr<Lyric> parse(T input);
}
