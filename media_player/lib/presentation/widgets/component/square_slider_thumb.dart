import 'package:flutter/material.dart';

class SquareSliderThumbShape extends SliderComponentShape {
  final double thumbSize;

  SquareSliderThumbShape({this.thumbSize = 10.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbSize, thumbSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    final Rect thumbRect = Rect.fromCenter(center: center, width: thumbSize, height: thumbSize);

    canvas.drawRect(thumbRect, paint);
  }
}