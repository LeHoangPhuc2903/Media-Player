import 'package:flutter/material.dart';

class PlaybackControlsWidget extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isPlaying;

  const PlaybackControlsWidget({
    Key? key,
    required this.onPlay,
    required this.onPause,
    required this.onNext,
    required this.onPrevious,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, size: 36),
          onPressed: onPrevious,
        ),
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 48),
          onPressed: isPlaying ? onPause : onPlay,
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, size: 36),
          onPressed: onNext,
        ),
      ],
    );
  }
}
