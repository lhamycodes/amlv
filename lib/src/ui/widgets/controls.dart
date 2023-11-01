import 'package:flutter/material.dart';

import '../../../amlv.dart';

/// Lyric viewer control [backward, play & pause, forward] buttons.
class LyricViewerControls extends StatefulWidget {
  /// The [AudioPlayer] instance.
  final AudioPlayer player;

  /// The current time progress of the audio.
  final int timeProgress;

  /// The duration of the audio.
  final int audioDuration;

  /// Whether the audio is playing or not.
  final bool isPlaying;

  /// The size of the icons.
  final double iconSize;

  /// The color of the icons.
  final Color iconColor;

  /// The color of the active elements.
  final Color? activeColor;

  /// The color of the inactive elements.
  final Color? inactiveColor;

  /// The callback for the backward button.
  final PlaybackControlBuilder? backwardBuilder;

  /// The callback for the forward button.
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
  /// Resume the audio player.
  resume() async {
    widget.player.resume();
  }

  /// Pause the audio player.
  pause() async {
    widget.player.pause();
  }

  /// Seek to a specific second.
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
