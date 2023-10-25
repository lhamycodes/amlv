import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import '../../amlv.dart' show Lyric;

abstract class LyricParser<T> {
  FutureOr<Lyric> parse(T input, Source? audio);
}
