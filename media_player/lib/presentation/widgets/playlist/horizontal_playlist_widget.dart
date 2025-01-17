import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/domain/usecases/get_playlists_usecase.dart';
import 'package:media_player/presentation/pages/playlist/playlist_page.dart';
import 'package:media_player/presentation/view_models/playlist_view_model.dart';

class HorizontalPlaylistWidget extends StatelessWidget {
  final List<Map<String, String>> playlists;

  const HorizontalPlaylistWidget({super.key, required this.playlists});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => PlaylistPage(
                PlaylistViewModel(Get.find<GetPlaylistsUseCase>()),
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
