import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon; // Font Awesome Icon
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double leftPadding;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.leftPadding = 0.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 80, bottom: 12),
      child: SizedBox(
        width: double.infinity, // Lấp đầy lề phải
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14), // Chiều cao nút
          ),
          icon: Icon(icon, color: textColor, size: 20),
          label: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
