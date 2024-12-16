import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/ui/player_page/player_page.dart';


class PlaylistPage extends StatelessWidget {
  final List<Map<String, String>> mediaItems;

  const PlaylistPage({Key? key, required this.mediaItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
      ),
      body: ListView.builder(
        itemCount: mediaItems.length,
        itemBuilder: (context, index) {
          final media = mediaItems[index];
          return GestureDetector(
            onTap: () {
              // Navigate to PlayerPage
              Get.to(() => PlayerPage(
                image: media['image']!,
                title: media['title']!,
                artist: media['artist']!,
              ));
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Image.asset(
                  media['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(media['title']!),
                subtitle: Text(media['artist']!),
                trailing: Icon(Icons.play_arrow),
              ),
            ),
          );
        },
      ),
    );
  }
}
