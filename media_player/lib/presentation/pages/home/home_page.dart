import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/home/home_modelview.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';
import 'package:media_player/presentation/widgets/component/banner_widget.dart';
import 'package:media_player/presentation/widgets/component/bottom_nav_widget.dart';
import 'package:media_player/presentation/widgets/playlist/horizontal_playlist_widget.dart';
import 'package:media_player/presentation/widgets/component/section_tile_widget.dart';

class HomePage extends StatelessWidget {
  static const PageIndex = 0;
  final HomeController controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.audioFiles.isEmpty && controller.playlists.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.music_off, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text("No audio or playlists found"),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => controller.scanAndLoadData(),
                  icon: Icon(Icons.refresh),
                  label: Text("Scan for Audio"),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerWidget(banners: []), // Replace with actual banners
             
              if (controller.audioFiles.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SectionTitleWidget(title: 'Audios'),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.audioFiles.length,
                  itemBuilder: (context, index) {
                    final audio = controller.audioFiles[index];
                    return ListTile(
                      title: Text(audio.title),
                      subtitle: Text(audio.artist),
                      leading: Icon(Icons.music_note),
                      onTap: () {
                        
                        print("🎵 Opening PlayerPage with: ${audio.filePath}");

                        Get.to(() => PlayerPage(audioUrl: audio.filePath));
                      },
                    );
                  },
                ),
              ],

             
              if (controller.playlists.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SectionTitleWidget(title: 'Playlists'),
                ),
                HorizontalPlaylistWidget(playlists: controller.playlists),
              ],
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: PageIndex,
        onTabSelected: (index) {
          switch (index) {
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
