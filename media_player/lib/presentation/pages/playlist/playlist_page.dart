import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist playlist;

  PlaylistPage({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
      ),
      body: playlist.audioFiles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.music_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  const Text("No audios in this playlist"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: playlist.audioFiles.length,
              itemBuilder: (context, index) {
                final audio = playlist.audioFiles[index];
                return ListTile(
                  title: Text(audio.title),
                  subtitle: Text(audio.artist),
                  leading: const Icon(Icons.music_note),
                  trailing: const Icon(Icons.play_arrow),
                  onTap: () {
                    Get.to(() => PlayerPage(), arguments: audio);
                  },
                );
              },
            ),
    );
  }
}

