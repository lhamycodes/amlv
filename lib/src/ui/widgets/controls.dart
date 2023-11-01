import 'package:flutter/material.dart';

import '../../../amlv.dart';

class LyricViewerControls extends StatefulWidget {
  final AudioPlayer player;
  final int timeProgress;
  final int audioDuration;
  final bool isPlaying;
  final double iconSize;
  final Color iconColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final PlaybackControlBuilder? backwardBuilder;
  final PlaybackControlBuilder? forwardBuilder;

  const LyricViewerControls({
    super.key,
    required this.player,
    required this.timeProgress,
    required this.audioDuration,
    required this.isPlaying,
    required this.iconSize,
    required this.iconColor,
    this.activeColor,
    this.inactiveColor,
    this.backwardBuilder,
    this.forwardBuilder,
  });

  @override
  State<LyricViewerControls> createState() => _LyricViewerControlsState();
}

class _LyricViewerControlsState extends State<LyricViewerControls> {
  resume() async {
    widget.player.resume();
  }

  pause() async {
    widget.player.pause();
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    widget.player.seek(newPos);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTimeString(widget.timeProgress),
                style: TextStyle(color: widget.activeColor),
              ),
              Text(
                getTimeString(widget.audioDuration),
                style: TextStyle(color: widget.activeColor),
              ),
            ],
          ),
          Slider(
            value: widget.timeProgress.toDouble(),
            max: widget.audioDuration.toDouble() < 1
                ? 10
                : widget.audioDuration.toDouble(),
            onChanged: (value) => seekToSec(value.toInt()),
            activeColor: widget.activeColor,
            inactiveColor: widget.inactiveColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.backwardBuilder != null) ...[
                PlayerIconButton(
                  icon: Icons.chevron_left,
                  size: widget.iconSize,
                  color: widget.iconColor,
                  onTap: () {
                    if (widget.backwardBuilder != null) {
                      widget.backwardBuilder!(widget.player, widget.isPlaying);
                    }
                  },
                ),
                horizontalSpace(20),
              ],
              PlayerIconButton(
                icon:
                    widget.isPlaying ? Icons.pause : Icons.play_arrow_outlined,
                size: widget.iconSize,
                color: widget.iconColor,
                onTap: () => widget.isPlaying ? pause() : resume(),
              ),
              if (widget.forwardBuilder != null) ...[
                horizontalSpace(20),
                PlayerIconButton(
                  icon: Icons.chevron_right,
                  size: widget.iconSize,
                  color: widget.iconColor,
                  onTap: () {
                    if (widget.forwardBuilder != null) {
                      widget.forwardBuilder!(widget.player, widget.isPlaying);
                    }
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
