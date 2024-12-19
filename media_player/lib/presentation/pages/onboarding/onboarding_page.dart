import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_player/core/utils/constants.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/widgets/media/app_logo.dart';
import 'package:media_player/presentation/widgets/text/terms_and_privacy_text.dart';
import 'package:media_player/presentation/widgets/text/custom_title.dart';
import 'package:media_player/presentation/widgets/button/custom_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.music_note, size: 80, color: Colors.purple),
            const SizedBox(height: 20),
            const Text(
              "Âm nhạc dựa trên tâm hồn của bạn",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Tạo nút bằng _buildButtons()
            ..._buildButtons(), // Dùng spread operator để thêm vào children
            const SizedBox(height: 20),
            // Điều khoản và chính sách bảo mật
            TermsAndPrivacyText(
              onTermsTap: () {
                print("Điều khoản Dịch vụ được nhấn");
              },
              onPrivacyTap: () {
                print("Chính sách Bảo mật được nhấn");
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildButtons() {
  return [
    CustomButton(
        key: ValueKey('facebook_button'),
        icon: FontAwesomeIcons.facebookF,
        label: "Tiếp tục với Facebook",
        backgroundColor: const Color(0xFF1877F2), // Màu Facebook
        textColor: Colors.white,
        onPressed: () {
          print("Đăng nhập với Facebook");
          Get.offNamed(Routes.home);
        },
      ),
      CustomButton(
        key: ValueKey('google_button'),
        icon: FontAwesomeIcons.google,
        label: "Tiếp tục với Google",
        backgroundColor: Colors.white, // Nền trắng cho Google
        textColor: Colors.black87,
        onPressed: () {
          print("Đăng nhập với Google");
          Get.offNamed(Routes.home);
        },
      ),
    ];
  }

           

