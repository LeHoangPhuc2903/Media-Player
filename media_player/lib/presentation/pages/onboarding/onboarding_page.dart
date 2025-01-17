import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:media_player/core/utils/constants.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/widgets/button/custom_button.dart';
import 'package:media_player/presentation/widgets/text/terms_and_privacy_text.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _textAnimation;
  late Animation<Offset> _buttonAnimation;
  late Animation<Offset> _termsAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Initialize Animations
    _textAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Bắt đầu ngoài khung hình bên phải
      end: Offset.zero, // Kết thúc tại vị trí gốc
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _buttonAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0.0), // Dịch xa hơn để có sự khác biệt
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _termsAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // Dịch xa hơn nữa
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            Hero(
              tag: 'logo',
              child: Icon(Icons.music_note, size: 80, color: Colors.purple),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _textAnimation,
              child: const Text(
                "Âm nhạc dựa trên tâm hồn của bạn",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            SlideTransition(
              position: _buttonAnimation,
              child: _buildButtons(),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _termsAnimation,
              child: TermsAndPrivacyText(
                onTermsTap: () => print("Điều khoản được nhấn"),
                onPrivacyTap: () => print("Chính sách bảo mật được nhấn"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        CustomButton(
          icon: FontAwesomeIcons.facebookF,
          label: AppStrings.facebookLabel,
          backgroundColor: AppColors.facebookColor,
          textColor: Colors.white,
          onPressed: () {
            print("Facebook login");
            Get.offNamed(Routes.home);
          },
        ),
        const SizedBox(height: 16),
        CustomButton(
          icon: FontAwesomeIcons.google,
          label: AppStrings.googleLabel,
          backgroundColor: AppColors.googleBackgroundColor,
          textColor: AppColors.googleTextColor,
          onPressed: () {
            print("Google login");
            Get.offNamed(Routes.home);
          },
        ),
      ],
    );
  }
}
