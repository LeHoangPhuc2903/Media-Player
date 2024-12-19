import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = 14.0,          // Kích thước mặc định
    this.color = Colors.black,     // Màu mặc định
    this.fontWeight = FontWeight.normal, // Độ đậm font mặc định
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.center, // Canh giữa
    );
  }
}