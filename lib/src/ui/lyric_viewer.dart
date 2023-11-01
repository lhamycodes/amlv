import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../amlv.dart';

/// Lyric Viewer / Player
class LyricViewer extends StatefulWidget {
  ///
  final Lyric lyric;
  final Color? activeColor;
  final Color? inactiveColor;
  final PlaybackControlBuilder? backwardBuilder;
  final PlaybackControlBuilder? forwardBuilder;
  final Function? onCompleted;
  final LyricChangedCallback? onLyricChanged;
  final double playerIconSize;
  final Color playerIconColor, gradientColor1, gradientColor2;

  const LyricViewer({
    super.key,
    required this.lyric,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white54,
    this.backwardBuilder,
    this.forwardBuilder,
    this.onCompleted,
    this.onLyricChanged,
    this.playerIconSize = 50,
    this.playerIconColor = Colors.white,
    this.gradientColor1 = Colors.red,
    this.gradientColor2 = Colors.black,
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
            _jumpToLine(i, "listener", play: false, d: time);
          }
        }
      });
    }
  }

  _jumpToLine(int index, String caller, {bool play = true, Duration? d}) {
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

  _disposer() {
    _controller.dispose();
    player.stop();
    player.dispose();
  }

  @override
  void dispose() {
    if (_audio) {
      _disposer();
    }
    super.dispose();
  }

  @override
  void initState() {
    cleanSwipeInterface();
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
      body: FluidBackground(
        color1: widget.gradientColor1,
        color2: widget.gradientColor2,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LyricViewerTitle(
                  lyric: widget.lyric,
                  titleColor: widget.activeColor,
                  subtitleColor: widget.inactiveColor,
                ),
                verticalSpace(10),
                LyricLinesBuilder(
                  controller: _controller,
                  currentLyricLine: _currentLyricLine,
                  lines: widget.lyric.lines,
                  onLineChanged: (int i, String caller) {
                    return _jumpToLine(i, caller);
                  },
                  activeColor: widget.activeColor,
                  inactiveColor: widget.inactiveColor,
                ),
                verticalSpace(10),
                LyricViewerControls(
                  player: player,
                  timeProgress: timeProgress,
                  audioDuration: audioDuration,
                  isPlaying: isPlaying,
                  iconSize: widget.playerIconSize,
                  iconColor: widget.playerIconColor,
                  activeColor: widget.activeColor,
                  inactiveColor: widget.inactiveColor,
                  backwardBuilder: widget.backwardBuilder,
                  forwardBuilder: widget.forwardBuilder,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
