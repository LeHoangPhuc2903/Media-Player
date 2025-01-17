import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/widgets/component/app_bar_widget.dart';
import 'package:media_player/presentation/widgets/component/banner_widget.dart';
import 'package:media_player/presentation/widgets/component/bottom_nav_widget.dart';
import 'package:media_player/presentation/widgets/playlist/horizontal_playlist_widget.dart';
import 'package:media_player/presentation/widgets/component/section_tile_widget.dart';
import 'package:media_player/data/mock_data.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const PageIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerWidget(banners: banners),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SectionTitleWidget(title: 'Featured Playlists'),
            ),
            HorizontalPlaylistWidget(playlists: playlists),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SectionTitleWidget(title: 'Recently Played'),
            ),
            HorizontalPlaylistWidget(playlists: playlists),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SectionTitleWidget(title: 'Top Charts'),
            ),
            HorizontalPlaylistWidget(playlists: playlists),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: PageIndex,
        onTabSelected: (index) {
           print('Tab selected: $index');                
          switch (index) {
          case 0:         
            break;          
          case 1: 
            Get.offAllNamed(Routes.search);
            break;
          case 2:
            Get.offAllNamed(Routes.profile);
            break;
          }
          
        },
      ),
    );
  }
}
