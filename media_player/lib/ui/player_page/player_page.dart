import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  final String image;
  final String title;
  final String artist;

  // Constructor to receive the media details
  const PlayerPage({
    Key? key,
    required this.image,
    required this.title,
    required this.artist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Media Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Media Title and Artist
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              artist,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 30),
            // You can add controls here (e.g., Play/Pause buttons, Seek bar)
            ElevatedButton(
              onPressed: () {
                // Handle play/pause functionality here
              },
              child: Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
