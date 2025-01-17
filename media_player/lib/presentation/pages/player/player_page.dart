import 'package:flutter/material.dart';
import 'package:media_player/domain/entities/track.dart';

class PlayerPage extends StatelessWidget {
  final Track? track; // Cho phép null

  PlayerPage({this.track});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(track?.title ?? 'No Song Found')),
      body: Center(
        child: track == null
            ? Text(
                'No song data available',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Now Playing: ${track!.title}'),
                  Text('Artist: ${track!.subtitle}'),
                ],
              ),
      ),
    );
  }
}
