import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/ui/home_page/home_page.dart';
import 'package:media_player/ui/onboarding_page/onboarding_page.dart';
import 'package:media_player/ui/splash_page/splash_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Player',
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashPage()),
        GetPage(name: '/onboard', page: () => OnboardPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}
