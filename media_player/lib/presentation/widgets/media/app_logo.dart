import 'package:flutter/material.dart';
import 'package:media_player/core/utils/constants.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color color;

  const AppLogo({
    super.key,
    this.size = 80.0, // Kích thước mặc định
    this.color = AppColors.primaryColor, // Màu mặc định
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.music_note,
      size: size,
      color: color,
    );
  }
}
