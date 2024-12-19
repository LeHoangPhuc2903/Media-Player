import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppStrings {
  static const String splashText1 = "Âm Nhạc Là Liều Thuốc Trái Tim";
  static const String splashText2 = "Âm Nhạc Là Món Ăn Tinh Thần";
  static const String splashText3 = "Âm Nhạc Là Nơi Kết Nối Tâm Hồn";
  static const String onboardingTitle = "Âm nhạc dựa trên tâm hồn của bạn";
  static const String facebookLabel = "Tiếp tục với Facebook";
  static const String googleLabel = "Tiếp tục với Google";
  static const String termsAndPrivacy = "Bằng cách tiếp tục, bạn đồng ý với Điều khoản Dịch vụ và Chính sách bảo mật của chúng tôi.";
  static const String termsText = "Điều khoản Dịch vụ";
  static const String privacyText = "Chính sách bảo mật";
}

class AppStyles {
  static const double splashFontSize = 16.0;  // Kích thước chữ cố định
  static const double splashSpacing = 12.0;   // Khoảng cách giữa các dòng
  // Font size và khoảng cách
  static const double titleFontSize = 24.0;
  static const double buttonFontSize = 16.0;
  static const double termsFontSize = 12.0;
  static const double spacing = 20.0; // Khoảng cách giữa các widget
}

class AppColors {
  // Màu sắc
  static const Color primaryColor = Colors.purple;
  static const Color termsTextColor = Colors.grey;
  static const Color linkColor = Colors.blue;

  static const Color facebookColor = Color(0xFF1877F2); // Màu Facebook
  static const Color googleBackgroundColor = Colors.white;
  static const Color googleTextColor = Colors.black87;
}

class AppIcons {
  static const IconData facebookIcon = FontAwesomeIcons.facebookF;
  static const IconData googleIcon = FontAwesomeIcons.google;
}

class AppPadding {
  static const double leftPadding = 24.0; // Lề trái
}
