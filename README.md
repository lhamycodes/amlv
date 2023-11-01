<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# AMLV

Apple Music Lyric Viewer, a Flutter package inspired by Apple Music's Lyrics Viewer, this package provides a widget that displays lyrics(srt, lrc, json) in a beautiful way.

## Use Case
- [x] Music Player
- [x] Audio Book Player
- [x] Podcast Player
- [x] Karaoke App

## Features

- [x] Support for srt, lrc, json lyrics parsing
- [x] Support for creating custom lyric parsers
- [x] Support for customizing the lyrics widget
- [x] Support for playing lyrics in sync with audio

## Preview

<p>
    <img src="https://raw.githubusercontent.com/lhamycodes/amlv/master/preview/demo.gif" width="200px" height="auto" hspace="20"/>
</p>

## Usage

```dart
import 'const.dart';
import 'package:flutter/material.dart';
import 'package:amlv/amlv.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMLV Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LrcLyricParser parser = LrcLyricParser();
  Lyric? lyric;

  @override
  void initState() {
    _loadLyrics();
    super.initState();
  }

  _loadLyrics() async {
    lyric = await parser.parse(lrcLyrics, UrlSource(lrcUrlSource));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return lyric != null
        ? LyricViewer(
            lyric: lyric!,
            onLyricChanged: (LyricLine line, String source) {
              // ignore: avoid_print
              print("$source: [${line.time}] ${line.content}");
            },
            onCompleted: () {
              // ignore: avoid_print
              print("Completed");
            },
            gradientColor1: const Color(0xFFCC9934),
            gradientColor2: const Color(0xFF444341),
          )
        : const SizedBox();
  }
}
```

## LICENSE
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

MIT License

Copyright (c) 2023 lhamy.codes

[LICENSE](/LICENSE) file
