import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  final Duration currentPosition;
  final Duration totalDuration;
  final ValueChanged<double> onSeek;

  const ProgressBarWidget({
    Key? key,
    required this.currentPosition,
    required this.totalDuration,
    required this.onSeek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: currentPosition.inSeconds.toDouble(),
          max: totalDuration.inSeconds.toDouble(),
          onChanged: onSeek,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatDuration(currentPosition)),
            Text(formatDuration(totalDuration)),
          ],
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
