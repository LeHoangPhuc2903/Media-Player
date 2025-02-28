import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/player/player_viewmodel.dart';
import 'package:media_player/presentation/widgets/player/square_slider_thumb.dart';

class PlayerPage extends StatelessWidget {
  final AudioController audioController = Get.find<AudioController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          audioController.currentTrack.value?.title ?? 'Unknown Title',
          overflow: TextOverflow.ellipsis,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => audioController.albumArt.value != null
                ? Image.memory(
                    audioController.albumArt.value!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.music_note, size: 150, color: Colors.blue)),
            SizedBox(height: 20),
            Obx(() => Text(
                  audioController.currentTrack.value?.title ?? 'Unknown Title',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            Obx(() => Text(
                  audioController.currentTrack.value?.artist ?? 'Unknown Artist',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                )),
            SizedBox(height: 20),
            Obx(() => SliderTheme(
                data: SliderThemeData(
                thumbShape: SquareSliderThumbShape(thumbSize: 12),                
                trackHeight: 2.5,
                trackShape: RectangularSliderTrackShape(),
                activeTrackColor: Colors.blueAccent,
                inactiveTrackColor: Colors.grey.shade300,
                thumbColor: Colors.blue,
                overlayColor: Colors.blue.withOpacity(0.2),
              ),
              child: Slider(
                  value: audioController.currentPosition.value.inSeconds.toDouble(),
                  max: audioController.totalDuration.value.inSeconds.toDouble(),
                  onChanged: (value) {
                    audioController.seek(Duration(seconds: value.toInt()));
                  },
                )),
            ),

            Obx(() => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay_10, size: 36),
                          onPressed: audioController.rewind,
                        ),
                        IconButton(
                          icon: Icon(
                            audioController.isPlaying.value
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            size: 50,
                            color: Colors.blue,
                          ),
                          onPressed: audioController.togglePlayPause,
                        ),
                        IconButton(
                          icon: Icon(Icons.forward_10, size: 36),
                          onPressed: audioController.forward,
                        ),
                      ],
                    ),                   
                  ],
                )
              ),
              Obx(() {
  if (audioController.queue.isEmpty) {
    return SizedBox.shrink();
  }
  return Expanded(
    
      child: QueueWidget(),
    
  );
})
          ],
        ),
      ),
    );
  }
}

class QueueWidget extends StatelessWidget {
  final AudioController audioController = Get.find<AudioController>();

  QueueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics:BouncingScrollPhysics(),
      itemCount: audioController.queue.length,
      itemBuilder: (context, index) {
        final audio = audioController.queue[index];
        return ListTile(
          title: Text(audio.title),
          subtitle: Text(audio.artist),
        );
      },
    ));
  }
}



