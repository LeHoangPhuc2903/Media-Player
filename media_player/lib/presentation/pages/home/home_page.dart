import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/presentation/pages/home/home_modelview.dart';
import 'package:media_player/presentation/navigation/routes.dart';

import 'package:media_player/presentation/pages/player/player_viewmodel.dart';

import 'package:media_player/presentation/widgets/component/bottom_nav_widget.dart';
import 'package:media_player/presentation/pages/player/mini_player.dart';
import 'package:media_player/presentation/widgets/playlist/vertical_playlist_widget.dart';
import 'package:logger/logger.dart';


class HomePage extends StatelessWidget {
  static const pageIndex = 0;
  final HomeController controller = Get.find<HomeController>();
  final AudioController audioController = Get.find<AudioController>();
  static final Logger logger = Logger();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trang chủ'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.music_note), text: 'Audios'),
              Tab(icon: Icon(Icons.playlist_play), text: 'Playlists'),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const LoadingWidget();
          }

          if (controller.audioFiles.isEmpty && controller.playlists.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.music_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  const Text("No audio or playlists found"),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => controller.scanAndLoadData(),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Scan for Audio"),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            children: [
              AudioListWidget(controller.audioFiles),

              controller.playlists.isEmpty?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.playlist_play, size: 80, color: Colors.grey),
                    const SizedBox(height: 10),
                    const Text("No playlists found"),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => controller.createNewPlaylist("New Playlist"),
                      icon: const Icon(Icons.add_box),
                      label: const Text("Create new playlist"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => controller.getAllPlaylist(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Refresh"),
                    ),
                  ],
                ),
                ) : VerticalPlaylistWidget(playlists: controller.playlists),
            ],
          );
        }),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => audioController.showMiniPlayer.value ? MiniPlayer() : const SizedBox.shrink()),

            BottomNavigationWidget(
              currentIndex: pageIndex,
              onTabSelected: (index) {
                if (index == 1) {
                  Get.toNamed(Routes.search);
                } else if (index == 2) {Get.toNamed(Routes.profile);}
              },
            ),
          ]),
      )
    );
  }
}

class AudioListWidget extends StatelessWidget {
  final RxList<Audiofile> audioFiles;
  final AudioController audioController = Get.find<AudioController>();

  AudioListWidget(this.audioFiles);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
      itemCount: audioFiles.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final audio = audioFiles[index];
        return ListTile(
          leading: audio.hasImage
              ? Image.memory(audio.albumArt!, width: 50, height: 50, fit: BoxFit.cover)
              : const Icon(Icons.music_note),
              
          title: Text(audio.title),
          subtitle: Text(audio.artist),
          onTap: () {
            if (audio.filePath.isNotEmpty) {
              HomePage.logger.i("🎵 Opening PlayerPage with: ${audio.filePath}");
              audioController.setAudio(audio);
              audioController.openPlayer();
            } else {
              HomePage.logger.w("⚠️ Invalid audio file path");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Invalid audio file path"))
              );
            }
          },
          trailing: IconButton(
            icon: const Icon(Icons.queue_music),
            onPressed: () {
              audioController.addToQueue(audio);
            },
          ),
        );
      },
    ));
  }
}



class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
