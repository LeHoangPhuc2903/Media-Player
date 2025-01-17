import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/core/services/audio_handler.dart';
import 'package:media_player/domain/usecases/get_playlists_usecase.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/pages/banner/banner_detail_page.dart';
import 'package:media_player/presentation/pages/home/home_page.dart';
import 'package:media_player/presentation/pages/onboarding/onboarding_page.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';
import 'package:media_player/presentation/pages/playlist/playlist_page.dart';
import 'package:media_player/presentation/pages/profile_page.dart';
import 'package:media_player/presentation/pages/search_page.dart';
import 'package:media_player/presentation/pages/splash/splash_page.dart';

import 'presentation/view_models/playlist_view_model.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo AudioHandler
  final audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.media_player.channel.audio',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
    ),
  );

  // Inject AudioHandler
  Get.put(audioHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Player',
      initialRoute: Routes.splash,
      getPages: [
        GetPage(name: Routes.splash, page: () => SplashPage()),
        GetPage(name: Routes.onboarding, page: () => OnboardingPage()),
        GetPage(name: Routes.home, page: () => HomePage()),
        GetPage(name: Routes.playlist, page: () => PlaylistPage(PlaylistViewModel(Get.find<GetPlaylistsUseCase>()), title: '', image: '')),
        GetPage(name: Routes.player, page: () => PlayerPage()),
        GetPage(name: Routes.search, page: () => SearchPage()),
        GetPage(name: Routes.profile, page: () => ProfilePage()),
        GetPage(name: '/banner_detail', page: () => BannerDetailPage(title: '', imageUrl: '')),
      ],
    );
  }
}
