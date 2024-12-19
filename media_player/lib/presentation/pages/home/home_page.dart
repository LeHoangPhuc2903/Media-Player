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
        'image': 'assets/images/banner_1.jpg',
        'title': 'New Music',
        'subtitle': 'FRIDAY',
      },
      {
        'image': 'assets/images/banner_2.jpg',
        'title': 'Top Hits',
        'subtitle': 'TRENDING',
      },
      {
        'image': 'assets/images/banner_3.jpg',
        'title': 'Chill Vibes',
        'subtitle': 'RELAX',
      },
    ];
    
    final playlists = [
      {'image': 'assets/images/playlist_1.jpg', 'title': 'Playlist 1'},
      {'image': 'assets/images/playlist_2.jpg', 'title': 'Playlist 2'},
      {'image': 'assets/images/playlist_3.jpg', 'title': 'Playlist 3'},
    ];

    return Scaffold(
      appBar: const AppBarTile(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerWidget(banners: banners), // Truyền danh sách banner
            SectionTitleWidget(
              title: 'Âm nhạc thịnh hành',
              onSeeAllPressed: () {
                print('Xem tất cả thịnh hành');
                Get.toNamed(Routes.playlist);
              },
            ),
            HorizontalPlaylistWidget(playlists: playlists),
            SectionTitleWidget(
              title: 'Gợi ý cho bạn',
              onSeeAllPressed: () {
                print('Xem tất cả gợi ý');
                Get.toNamed(Routes.playlist);
              },
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
