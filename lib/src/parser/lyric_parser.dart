import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import '../../amlv.dart' show Lyric;

/// Base class for all lyric parsers.
abstract class LyricParser<T> {
  FutureOr<Lyric> parse(T input, Source audio);
}
