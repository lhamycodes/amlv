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
      title: 'Flutter Demo',
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
  SrtLyricParser parser = SrtLyricParser();
  Lyric? lyric;

  @override
  void initState() {
    _loadLyrics();
    super.initState();
  }

  _loadLyrics() {
    lyric = parser.parse(
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
      null,
      title: "Test",
      artist: "Test",
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return lyric != null
        ? LyricViewer(
            lyric: lyric!,
            onLyricChanged: (LyricLine line, String source) {
              print("${line.time}: ${line.content}");
            },
            onCompleted: () {
              print("Completed");
            },
          )
        : const SizedBox();
  }
}
