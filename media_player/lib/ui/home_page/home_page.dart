import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/ui/playlist_page/playlist_page.dart';
import 'package:media_player/ui/player_page/player_page.dart';

class HomePage extends StatelessWidget {
  final List<String> imageList = [
    'assets/images/slider_image_1.jpg',
    'assets/images/slider_image_2.jpg',
    'assets/images/slider_image_3.jpg',
  ];

  final List<Map<String, String>> mediaItems = [
    {
      'image': 'assets/images/media_image_1.jpg',
      'title': 'Song Title 1',
      'artist': 'Artist 1',
    },
    {
      'image': 'assets/images/media_image_2.jpg',
      'title': 'Song Title 2',
      'artist': 'Artist 2',
    },
    {
      'image': 'assets/images/media_image_3.jpg',
      'title': 'Song Title 3',
      'artist': 'Artist 3',
    },
  ];

  final List<Map<String, String>> horizontalScrollerItems = [
    {
      'image': 'assets/images/cover_1.jpg',
      'title': 'Playlist 1',
    },
    {
      'image': 'assets/images/cover_2.jpg',
      'title': 'Playlist 2',
    },
    {
      'image': 'assets/images/cover_3.jpg',
      'title': 'Playlist 3',
    },
    {
      'image': 'assets/images/cover_4.jpg',
      'title': 'Playlist 4',
    },
  ];

  final CarouselSliderController carouselSliderController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Trang chủ'),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_play),
            onPressed: () {
              Get.to(() => PlaylistPage(mediaItems: mediaItems)); // Navigate to Playlist Page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Slider
            CarouselSlider(
              carouselController: carouselSliderController, // Correct controller type in v5.0.0
              items: imageList.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                height: 200,
              ),
            ),
            
            // Horizontal Scroller
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Playlists',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: horizontalScrollerItems.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item['image']!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                item['title']!,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            

            // Media List (Scrollable)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mediaItems.length,
                itemBuilder: (context, index) {
                  final media = mediaItems[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => PlayerPage(
                        image: media['image']!,
                        title: media['title']!,
                        artist: media['artist']!,
                      ));
                    },
                  
                  child: MediaTile(
                    image: media['image']!,
                    title: media['title']!,
                    artist: media['artist']!,
                    
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaTile extends StatelessWidget {
  final String image;
  final String title;
  final String artist;

  const MediaTile({
    Key? key,
    required this.image,
    required this.title,
    required this.artist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Image.asset(
          image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(artist),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
