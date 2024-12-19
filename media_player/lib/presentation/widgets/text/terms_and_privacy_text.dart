import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndPrivacyText extends StatelessWidget {
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const TermsAndPrivacyText({
    Key? key,
    required this.onTermsTap,
    required this.onPrivacyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Bằng cách tiếp tục, bạn đồng ý với ",
        style: TextStyle(fontSize: 12, color: Colors.grey),
        children: [
          TextSpan(
            text: "Điều khoản Dịch vụ",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTermsTap,
          ),
          TextSpan(
            text: " và ",
          ),
          TextSpan(
            text: "Chính sách bảo mật",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
          ),
          const TextSpan(text: "."),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
