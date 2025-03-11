import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/player/player_viewmodel.dart';

class MiniPlayer extends StatelessWidget {
  final AudioController audioController = Get.find<AudioController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (audioController.currentTrack.value == null) {
        return SizedBox.shrink();
      }

      return Stack(
        alignment: Alignment.topCenter,
        children: [
          // Mini player content with tap gesture to open the player
          GestureDetector(
            onTap: audioController.openPlayer,
            child: CustomPaint(
              painter: BorderPainter(),
              child: Container(
                padding: const EdgeInsets.only(top: 16, bottom: 12, left: 12, right: 12),
                color: Colors.black,
                child: Row(
                  children: [
                    const Icon(Icons.music_note, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            audioController.currentTrack.value?.title ?? 'Unknown Title',
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            audioController.currentTrack.value?.artist ?? 'Unknown Artist',
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      iconSize: 32,
                      icon: const Icon(Icons.replay_10, color: Colors.white),
                      onPressed: audioController.rewind,
                    ),
                    IconButton(
                      iconSize: 32,
                      icon: Icon(
                        audioController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: audioController.togglePlayPause,
                    ),
                    IconButton(
                      iconSize: 32,
                      icon: const Icon(Icons.forward_10, color: Colors.white),
                      onPressed: audioController.forward,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Slider Layer (Painted above the mini-player)
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true, // Let gestures pass through for content below
              child: CustomPaint(
                painter: SliderPainter(
                  progress: audioController.currentPosition.value.inSeconds.toDouble(),
                  max: audioController.totalDuration.value.inSeconds.toDouble(),
                  thumbSize: 12, // Custom thumb size
                ),
              ),
            ),
          ),

          // Gesture Detector for Slider Interaction (Only captures top slider gestures)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 16, // Restrict touch area for the slider only
            child: GestureDetector(
              onPanUpdate: (details) {
                double newValue = (details.localPosition.dx /
                        MediaQuery.of(context).size.width)
                    .clamp(0.0, 1.0);
                final newPosition = Duration(
                    seconds: (audioController.totalDuration.value.inSeconds *
                            newValue)
                        .toInt());
                audioController.seek(newPosition);
              },
            ),
          ),
        ],
      );
    });
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final borderPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SliderPainter extends CustomPainter {
  final double progress;
  final double max;
  final double thumbSize;

  SliderPainter({
    required this.progress,
    required this.max,
    this.thumbSize = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final inactivePaint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final sliderPaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final thumbPaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw inactive slider track
    canvas.drawLine(
      Offset(0, 0),
      Offset(size.width, 0),
      inactivePaint,
    );

    // Draw active progress of the slider
    double progressWidth = (progress / max) * size.width;
    canvas.drawLine(
      Offset(0, 0),
      Offset(progressWidth, 0),
      sliderPaint,
    );

    // Draw custom square thumb
    final Rect thumbRect = Rect.fromCenter(
      center: Offset(progressWidth, 0),
      width: thumbSize,
      height: thumbSize,
    );
    canvas.drawRect(thumbRect, thumbPaint);

    // Optional border for thumb visibility
    canvas.drawRect(thumbRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
