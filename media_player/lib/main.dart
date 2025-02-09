import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:media_player/data/datasources/local_impl.dart';
import 'package:media_player/data/repositories/local_audio_repository.dart';
import 'package:media_player/data/repositories/local_playlist_repository.dart';
import 'package:media_player/data/repositories/local_user_repository.dart';
import 'package:media_player/domain/repositories/audio_repository.dart';
import 'package:media_player/domain/repositories/playlist_repository.dart';
import 'package:media_player/domain/repositories/user_repository.dart';
import 'package:media_player/domain/usecases/audio/get_all_audio.dart';
import 'package:media_player/domain/usecases/audio/scan_device_for_audio.dart';
import 'package:media_player/domain/usecases/playlist/playlist_controller.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/pages/home/home_modelview.dart';
import 'package:media_player/presentation/pages/home/home_page.dart';
import 'package:media_player/presentation/pages/onboarding/onboarding_page.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';
import 'package:media_player/presentation/pages/splash/splash_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = LocalDatabase();

  final audioRepository = LocalAudioRepository(LocalAudioDataSourceImpl(database));
  final playlistRepository = LocalPlaylistRepository(LocalPlaylistDataSourceImpl(database));
  final userRepository = LocalUserRepository(LocalUserDataSourceImpl(database));

  Get.put<AudioRepository>(audioRepository);
  Get.put<PlaylistRepository>(playlistRepository);
  Get.put<UserRepository>(userRepository);

  Get.put(HomeController(
    getAllAudio: GetAllAudio(audioRepository),
    getAllPlaylist: GetAllPlaylist(playlistRepository),
    scanDeviceForAudioFiles: ScanDeviceForAudioFiles(audioRepository),
  ));

  runApp(MyApp());
}

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

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
        GetPage(name: Routes.player, page: () => PlayerPage(audioUrl: '')),
        //GetPage(name: Routes.playlist, page: () => PlaylistPage(backgroundImage: '', title: '', songs: [], image: '')),
        //GetPage(name: Routes.search, page: () => SearchPage()),
        //GetPage(name: Routes.profile, page: () => ProfilePage()),
        //GetPage(name: '/banner_detail', page: () => BannerDetailPage(title: '', imageUrl: '')),
      ],
    );
  }
}
