import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../amlv.dart';

typedef PlaybackControlBuilder = Function(AudioPlayer player, bool isPlaying);
typedef LyricChangedCallback = Function(LyricLine, String);

class LyricViewer extends StatefulWidget {
  final Lyric lyric;
  final Color? activeColor;
  final Color? inactiveColor;
  final PlaybackControlBuilder? backwardBuilder;
  final PlaybackControlBuilder? forwardBuilder;
  final Function? onCompleted;
  final LyricChangedCallback? onLyricChanged;
  final double playerIconSize;
  final Color playerIconColor;

  const LyricViewer({
    super.key,
    required this.lyric,
    this.activeColor = const Color(0xFF000000),
    this.inactiveColor = const Color(0xFF828282),
    this.backwardBuilder,
    this.forwardBuilder,
    this.onCompleted,
    this.onLyricChanged,
    this.playerIconSize = 50,
    this.playerIconColor = const Color(0xFF000000),
  });

  @override
  State<LyricViewer> createState() => _LyricViewerState();
}

class _LyricViewerState extends State<LyricViewer> {
  int _currentLyricLine = 0;

  final player = AudioPlayer();
  bool isPlaying = false;

  bool get _audio => widget.lyric.audio != null;

  int timeProgress = 0;
  int audioDuration = 0;

  final AutoScrollController _controller = AutoScrollController();

  _playAudio() {
    _currentLyricLine = 0;
    player.stop();
    Source? source = widget.lyric.audio;
    if (source != null) {
      player.play(source);
      player.onDurationChanged.listen((duration) {
        audioDuration = duration.inSeconds;
      });
      player.onPositionChanged.listen((time) {
        setState(() {
          timeProgress = time.inSeconds;
        });
        if (isPlaying) {
          int i = widget.lyric.lines.indexWhere((li) => li.time > time);
          if (i > 0) {
            i--;
          }
          if (i != _currentLyricLine && i < widget.lyric.lines.length) {
            jumpToSubtitle(i, "listener", play: false, d: time);
          }
        }
      });
    }
  }

  jumpToSubtitle(int index, String caller, {bool play = true, Duration? d}) {
    List<LyricLine> lines = widget.lyric.lines;
    if (index > lines.length - 1) {
      return;
    }
    if (index == -1) {
      index = lines.length - 1;
    }

    LyricLine line = lines[index];
    Duration duration = d ?? line.time;
    _controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    setState(() {
      _currentLyricLine = index;
      if (play) {
        player.seek(duration);
        if (player.state != PlayerState.playing) {
          player.resume();
        }
      }
      if (widget.onLyricChanged != null) {
        widget.onLyricChanged!(line, caller);
      }
    });
  }

  disposer() {
    _controller.dispose();
    player.stop();
    player.dispose();
  }

  @override
  void dispose() {
    if (_audio) {
      disposer();
    }
    super.dispose();
  }

  resume() async {
    player.resume();
  }

  pause() async {
    player.pause();
  }

  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    player.seek(newPos);
  }

  @override
  void initState() {
    _playAudio();
    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        if (widget.onCompleted != null) {
          widget.onCompleted!();
        }
      }
      bool value = event == PlayerState.playing;
      if (mounted) {
        setState(() {
          isPlaying = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.lyric.canShowTitle
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.lyric.title!),
                  Text(widget.lyric.artist!, style: TextStyle(fontSize: 12))
                ],
              )
            : null,
        centerTitle: false,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _controller,
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: generateLyricItems(widget.lyric.lines),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(getTimeString(timeProgress)),
                      Text(getTimeString(audioDuration)),
                    ],
                  ),
                  Slider(
                    value: timeProgress.toDouble(),
                    max: audioDuration.toDouble() < 1
                        ? 10
                        : audioDuration.toDouble(),
                    onChanged: (value) {
                      seekToSec(value.toInt());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.backwardBuilder != null) ...[
                        PlayerIconButton(
                          icon: Icons.chevron_left,
                          size: widget.playerIconSize,
                          color: widget.playerIconColor,
                          onTap: () {
                            if (widget.backwardBuilder != null) {
                              widget.backwardBuilder!(player, isPlaying);
                            }
                          },
                        ),
                        horizontalSpace(20),
                      ],
                      PlayerIconButton(
                        icon:
                            isPlaying ? Icons.pause : Icons.play_arrow_outlined,
                        size: widget.playerIconSize,
                        color: widget.playerIconColor,
                        onTap: () => isPlaying ? pause() : resume(),
                      ),
                      if (widget.forwardBuilder != null) ...[
                        horizontalSpace(20),
                        PlayerIconButton(
                          icon: Icons.chevron_right,
                          size: widget.playerIconSize,
                          color: widget.playerIconColor,
                          onTap: () {
                            if (widget.forwardBuilder != null) {
                              widget.forwardBuilder!(player, isPlaying);
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> generateLyricItems(List<LyricLine>? lines) {
    List<Widget> items = [];
    for (var i = 0; i < lines!.length; i++) {
      items.add(AutoScrollTag(
        controller: _controller,
        index: i,
        key: ValueKey(i),
        child: GestureDetector(
          onTap: () => jumpToSubtitle(i, "seeker"),
          child: Text(
            lines[i].content,
            style: TextStyle(
              color: _currentLyricLine == i
                  ? widget.activeColor
                  : widget.inactiveColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
      ));
      if (i != lines.length - 1) items.add(SizedBox(height: 15));
    }
    return items;
  }

  Widget verticalSpace(double height) => SizedBox(height: height);
  Widget horizontalSpace(double width) => SizedBox(width: width);
}
