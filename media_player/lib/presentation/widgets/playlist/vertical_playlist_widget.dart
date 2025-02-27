import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/presentation/pages/playlist/playlist_page.dart';


class VerticalPlaylistWidget extends StatelessWidget {
  final List<Playlist> playlists; 
  VerticalPlaylistWidget({required this.playlists});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            leading: const Icon(Icons.playlist_play, size: 40),
            title: Text(playlist.name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${playlist.audioFiles.length} Songs'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => PlaylistPage(playlist: playlist));
            },
          ),
        );
      },
    );
  }
}
