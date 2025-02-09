import 'package:flutter/material.dart';

import 'package:media_player/domain/entities/playlist.dart';



class HorizontalPlaylistWidget extends StatelessWidget {
  final List<Playlist> playlists; 
  HorizontalPlaylistWidget({required this.playlists});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(Icons.playlist_play, size: 40),
                Text(playlist.name),
              ],
            ),
          ),
        );
      },
    );
  }
}
