import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/player/player_viewmodel.dart';

class MiniPlayer extends StatelessWidget {
  final AudioController audioController = Get.find<AudioController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      
      if (audioController.currentTrack.value == null) {
        return SizedBox.shrink();
      }
      return AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: GestureDetector(
        onTap: () {
          audioController.openPlayer();
        },
        child: Container(
          color: Colors.grey[900],
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.music_note, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audioController.currentTrack.value?.title ?? 'Unknown Title',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      audioController.currentTrack.value?.artist ?? 'Unknown Artist',
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.replay_10,
                  color: Colors.white,),
                onPressed: audioController.rewind,
              ),
              IconButton(
                icon: Icon(
                  audioController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: audioController.togglePlayPause,
              ),
              IconButton(
                icon: Icon(
                  Icons.forward_10,
                  color: Colors.white,),
                onPressed: audioController.forward,
              ),
            ],
          ),
        ),
      ),
    );   
    });
  }
}


