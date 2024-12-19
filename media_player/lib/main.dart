import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/navigation/navigation_controller.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/pages/home/home_page.dart';
import 'package:media_player/presentation/pages/onboarding/onboarding_page.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';
import 'package:media_player/presentation/pages/playlist/playlist_page.dart';
import 'package:media_player/presentation/pages/splash/splash_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Đăng ký NavigationController toàn cục
    Get.put(NavigationController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Player',
      initialRoute: Routes.splash, // Sử dụng route từ Routes
      getPages: [
        GetPage(name: Routes.splash, page: () => SplashPage()),
        GetPage(name: Routes.onboarding, page: () => OnboardingPage()),
        GetPage(name: Routes.home, page: () => HomePage()),
        GetPage(name: Routes.playlist, page: () => PlaylistPage(
          mediaItems: [], // Thay bằng dữ liệu thực
        )),
        GetPage(name: Routes.player, page: () => PlayerPage()),
      ],
    );
  }
}