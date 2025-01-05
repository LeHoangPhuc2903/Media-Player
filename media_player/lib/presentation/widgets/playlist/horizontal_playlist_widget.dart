import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/playlist/playlist_page.dart';

class HorizontalPlaylistWidget extends StatelessWidget {
  final List<Map<String, String>> playlists;

  const HorizontalPlaylistWidget({Key? key, required this.playlists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => PlaylistPage(
                title: playlist['title']!,
                image: playlist['image']!,
              ));
            },
            child: Container(
              width: 150,
              margin: EdgeInsets.all(8.0),
              
              child: Column(
                children: [
                  Image.asset(playlist['image']!),
                  Text(playlist['title']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
