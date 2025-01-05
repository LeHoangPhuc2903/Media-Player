import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';

class PlaylistPage extends StatelessWidget {
  final String title;
  final String image;

  PlaylistPage({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> songs = [
      {'title': 'Song 1', 'subtitle': 'Artist 1', 'path': 'lib/data/assets/song1.mp3'},
      {'title': 'Song 2', 'subtitle': 'Artist 2', 'path': 'lib/data/assets/song2.mp3'},
      {'title': 'Song 3', 'subtitle': 'Artist 3', 'path': 'lib/data/assets/song3.mp3'},
      {'title': 'Song 4', 'subtitle': 'Artist 4', 'path': 'lib/data/assets/song2.mp3'},
      {'title': 'Song 1', 'subtitle': 'Artist 1', 'path': 'lib/data/assets/song1.mp3'},
      {'title': 'Song 2', 'subtitle': 'Artist 2', 'path': 'lib/data/assets/song2.mp3'},
      {'title': 'Song 3', 'subtitle': 'Artist 3', 'path': 'lib/data/assets/song3.mp3'},
      {'title': 'Song 4', 'subtitle': 'Artist 4', 'path': 'lib/data/assets/song2.mp3'},
      {'title': 'Song 1', 'subtitle': 'Artist 1', 'path': 'lib/data/assets/song1.mp3'},
      {'title': 'Song 2', 'subtitle': 'Artist 2', 'path': 'lib/data/assets/song1.mp3'},
      {'title': 'Song 3', 'subtitle': 'Artist 3', 'path': 'lib/data/assets/song2.mp3'},
      {'title': 'Song 4', 'subtitle': 'Artist 4', 'path': 'lib/data/assets/song1.mp3'},
      {'title': 'Song 1', 'subtitle': 'Artist 1', 'path': 'lib/data/assets/song2.mp3'},
      {'title': 'Song 2', 'subtitle': 'Artist 2', 'path': 'lib/data/assets/song3.mp3'},
      {'title': 'Song 3', 'subtitle': 'Artist 3', 'path': 'lib/data/assets/song1.mp3'},
      {'title': 'Song 4', 'subtitle': 'Artist 4', 'path': 'lib/data/assets/song3.mp3'},
      {'title': 'Song 1', 'subtitle': 'Artist 1', 'path': 'lib/data/assets/song2.mp3'},
      {'title': 'Song 2', 'subtitle': 'Artist 2', 'path': 'lib/data/assets/song1.mp3'},
      {'title': 'Song 3', 'subtitle': 'Artist 3', 'path': 'lib/data/assets/song3.mp3'},
      
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.blue,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
        
                  Container(
                  color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final song = songs[index];
                return ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text(song['title']!),
                  subtitle: Text(song['subtitle']!),
                  onTap: () {
                    final songData = {
                      'title': song['title']!,
                      'subtitle': song['subtitle']!,
                      'path': song['path']!,
                      'playlistTitle': title,
                      'playlistImage': image,
                    };
                    Get.to(() => PlayerPage(songData: songData));
                  },
                );
              },
              childCount: songs.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Now Playing: $title',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_upward, color: Colors.white),
                onPressed: () {
                  // Xử lý mở trang PlayerPage
                  Get.to(() => PlayerPage(songData: {},));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
