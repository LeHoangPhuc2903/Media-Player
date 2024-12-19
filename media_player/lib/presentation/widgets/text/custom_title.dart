import 'package:flutter/material.dart';
import 'package:media_player/core/utils/constants.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;    

  const CustomTitle({
    Key? key,
    required this.text,
    this.fontSize = 24.0, // Kích thước mặc định
    this.color = Colors.purple, // Màu chữ mặc định
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize, // Sử dụng tham số fontSize
        fontWeight: FontWeight.bold,
        color: color,       // Sử dụng tham số color
      ),
      textAlign: TextAlign.center,
    );
  }
}

