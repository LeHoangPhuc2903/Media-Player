import 'package:flutter/material.dart';
import 'package:media_player/core/utils/constants.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color color; // Thêm tham số color

  const AppLogo({
    Key? key,
    this.size = 80.0, // Kích thước mặc định
    this.color = Colors.purple, // Màu mặc định
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.music_note,
      size: size,
      color: color,
    );
  }
}
