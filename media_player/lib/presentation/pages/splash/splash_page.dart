import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/core/utils/constants.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/pages/onboarding/onboarding_page.dart';
import 'package:media_player/presentation/widgets/text/custom_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  bool _startAnimation = false;
  
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        _startAnimation = true;
      });
    });

    Future.delayed(const Duration(seconds: 3), () async {
    setState(() {
        _startAnimation = false; // Hoàn tất animation
      });
      await Future.delayed(const Duration(milliseconds: 500));
      Get.to(() => const OnboardingPage(), transition: Transition.fadeIn);
    });
  }

  Widget splashText(String text) {
    return CustomText(
      text: text,
      fontSize: AppStyles.splashFontSize,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Hero(
                tag: 'logo',
                child: Icon(Icons.music_note, size: 100, color: Colors.purple),
              ),
            ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: _startAnimation ? 1 : 0,
                  child: splashText(AppStrings.splashText1),
                ),
                AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: _startAnimation ? 1 : 0,
                  child: splashText(AppStrings.splashText2),
                ),
                AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: _startAnimation ? 1 : 0,
                  child: splashText(AppStrings.splashText3),
                ),
                const SizedBox(height: 40),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
           