import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/home/home_modelview.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';
import 'package:media_player/presentation/pages/player/player_viewmodel.dart';
import 'package:media_player/presentation/pages/playlist/playlist_page.dart';

import 'create_playlist_widget.dart';

class VerticalPlaylistWidget extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final AudioController audioController = Get.find<AudioController>();

  VerticalPlaylistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return ListView.builder(
            itemCount: controller.playlists.length,
            itemBuilder: (context, index) {
              final playlist = controller.playlists[index];
              return ListTile(
                title: Text(playlist.name),
                subtitle: Text("${playlist.audioIds.length} audios"),
                onTap: () async {
                  Get.to(() => PlaylistPage(playlist: playlist));
                },
                trailing: IconButton(
                  icon: const Icon(Icons.queue_music),
                  onPressed: () {
                    for (var audio in playlist.audioFiles) {
                      audioController.addToQueue(audio);
                    }
                    Get.to(() => PlayerPage());
                  },
                ),
              );
            },
          );
        }),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => PlaylistCreationDialog(),
                barrierDismissible: false,
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
