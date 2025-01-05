import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/widgets/component/app_bar_widget.dart';
import 'package:media_player/presentation/widgets/component/banner_widget.dart';
import 'package:media_player/presentation/widgets/component/bottom_nav_widget.dart';
import 'package:media_player/presentation/widgets/playlist/horizontal_playlist_widget.dart';
import 'package:media_player/presentation/widgets/component/section_tile_widget.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
   final banners = [
  {
    'image': 'lib/data/assets/images/adventure.webp',
    'title': 'Adventure Awaits',
    'subtitle': 'EXPLORE',
  },
  {
    'image': 'lib/data/assets/images/dream.webp',
    'title': 'Dreams of Tomorrow',
    'subtitle': 'IMAGINE',
  },
  {
    'image': 'lib/data/assets/images/chill.webp',
    'title': 'Chill Vibes',
    'subtitle': 'RELAX',
  },
];
    
   final playlists = [
  {'image': 'lib/data/assets/images/echo.webp', 'title': 'Echoes of the Night'},
  {'image': 'lib/data/assets/images/party.webp', 'title': 'Party All Night'},
  {'image': 'lib/data/assets/images/chill.webp', 'title': 'Chill Time'}, 
];


    return Scaffold(
      appBar: const AppBarTile(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerWidget(banners: banners), // Truyền danh sách banner
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
        currentIndex: 0,
        onTabSelected: (index) {
          print('Selected Tab: $index');
          
        },
      ),
    );
  }
}
