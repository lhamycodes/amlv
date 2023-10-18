// ignore_for_file: avoid_print

import 'package:amlv/amlv.dart';

Future<void> main() async {
  LyricParser parser = SrtLyricParser();
  Lyric lyric = await parser.parse('''
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
    and what stays off.''');

  for (var line in lyric.lines) {
    print("[${line.time}]: ${line.content}");
  }

  LyricParser lrcParser = LrcLyricParser();
  Lyric lrcLyric = await lrcParser.parse('''
[ar:The Beatles]
[ti:Help!]
[al:Help!]
[length:02:19.23]

[00:01.00]Help! I need somebody
[00:02.91]Help! Not just anybody
[00:05.16]Help! You know I need someone
[00:07.91]Help!
[00:10.66](When) When I was younger (When I was young) so much younger than today
[00:15.66](I never need) I never needed anybody's help in any way
[00:20.76](Now) But now these days are gone (These days are gone) and I'm not so self assured
[00:25.43](And now I find) Now I find I've changed my mind, I've opened up the doors
[00:30.42]Help me if you can, I'm feeling down
[00:34.94]And I do appreciate you being 'round
[00:40.74]Help me get my feet back on the ground
[00:44.94]Won't you please, please help me?
[00:50.94](Now) And now my life has changed (My life has changed) in oh so many ways
[00:56.20](My independence) My independence seems to vanish in the haze
[01:01.21](But) But ev'ry now (Every now and then) and then I feel so insecure
[01:05.92](I know that I) I know that I just need you like I've never done before
[01:11.00]Help me if you can, I'm feeling down
[01:15.43]And I do appreciate you being 'round
[01:20.47]Help me get my feet back on the ground
[01:25.64]Won't you please, please help me?
[01:31.43]When I was younger, so much younger than today
[01:36.65]I never needed anybody's help in any way
[01:41.39](Now) But now these days are gone (These days are gone) and I'm not so self assured
[01:46.17](And now I find) Now I find I've changed my mind, I've opened up the doors
[01:51.38]Help me if you can, I'm feeling down
[01:56.17]And I do appreciate you being 'round
[02:01.36]Help me get my feet back on the ground
[02:06.08]Won't you please, please help me?
[02:10.12]Help me, help me
[02:12.85]Ooh
  ''');

  print(lrcLyric.album);
  for (var line in lrcLyric.lines) {
    print("[${line.time}]: ${line.content}");
  }
}
