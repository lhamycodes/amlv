import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../amlv.dart';

/// Removes the swipe part of the screen on android devices
Future cleanSwipeInterface() async {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
    );
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}

/// Converts [seconds] to human readable time in mm:ss
String getTimeString(int seconds) {
  String minuteString =
      '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
  String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
  return '$minuteString:$secondString'; // Returns a string with the format mm:ss
}

/// returns a SizedBox of height [height]
Widget verticalSpace(double height) => SizedBox(height: height);

/// returns a SizedBox of width [width]
Widget horizontalSpace(double width) => SizedBox(width: width);

/// Define type that accept [player], and boolean [isPlaying]
typedef PlaybackControlBuilder = Function(AudioPlayer player, bool isPlaying);

/// Define type that accept [LyricLine] and [String]
typedef LyricChangedCallback = Function(LyricLine, String);
