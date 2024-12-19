import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/core/utils/constants.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/widgets/text/custom_text.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 3), () {
      // Sử dụng GetX navigation
      Get.offNamed(Routes.onboarding); // Chuyển sang OnboardingPage
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
        crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa theo chiều ngang
        children: [
          // Expanded để logo và text cân bằng
          Expanded(
            child: Center(
              child: Icon(Icons.music_note, size: 100, color: Colors.purple),
            ),
          ),
          // Các dòng chữ tái sử dụng với CustomText
          const CustomText(
            key: ValueKey('splashtext1'),
            text: AppStrings.splashText1,
            fontSize: AppStyles.splashFontSize,
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: AppStyles.splashSpacing),
          const CustomText(
            key: ValueKey('splashtext2'),
            text: AppStrings.splashText2,
            fontSize: AppStyles.splashFontSize,
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: AppStyles.splashSpacing),
          const CustomText(
            key: ValueKey('splashtext3'),
            text: AppStrings.splashText3,
            fontSize: AppStyles.splashFontSize,
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
