import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';

class AudioController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  // State
  RxBool showMiniPlayer = false.obs;
  Rx<Audiofile?> currentTrack = Rx<Audiofile?>(null);
  RxBool isPlaying = false.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Uint8List?> albumArt = Rx<Uint8List?>(null);
  RxList<Audiofile> queue = <Audiofile>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Listen to Player State Changes
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      if (state.processingState == ProcessingState.completed) {
        stop();
      }
      showMiniPlayer.value = isPlaying.value || currentPosition.value > Duration.zero;
    });

    // Listen to Position Changes
    audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });

    // Listen to Duration Changes
    audioPlayer.durationStream.listen((duration) {
      totalDuration.value = duration ?? Duration.zero;
    });
  }

  // Load Audio and Extract Metadata
  Future<void> setAudio(Audiofile audio) async {
    try {
      print("🎵 Trying to load: ${audio.filePath}");

      File audioFile = File(audio.filePath);
      if (!audioFile.existsSync()) {
        Get.snackbar("Error", "Audio file not found!", snackPosition: SnackPosition.BOTTOM);
        return;
      }
      
      final metadata = await readMetadata(audioFile);
      print("🔍 Pictures found: ${metadata.pictures.length}");
      if (metadata.pictures.isNotEmpty) {
        final Picture picture = metadata.pictures.first;
        albumArt.value = picture.bytes;
      } else {
        albumArt.value = null;
      }

      await audioPlayer.setFilePath(audio.filePath);
      currentTrack.value = audio;
      play();
    } catch (e) {
      Get.snackbar("Error", "Failed to load audio.", snackPosition: SnackPosition.BOTTOM);
      print("❌ Error loading audio: $e");
    }
  }

  // Play and Pause
  void play() => audioPlayer.play();
  void pause() => audioPlayer.pause();
  void togglePlayPause() {
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  // Stop Playback
  Future<void> stop() async {
    await audioPlayer.stop();
    currentPosition.value = Duration.zero;
    isPlaying.value = false;

    if (queue.isNotEmpty) {
    final nextTrack = queue.removeAt(0);
    await setAudio(nextTrack);
  }
  }

  // Seek
  void seek(Duration position) {
    audioPlayer.seek(position);
  }

  // Rewind and Forward
  void rewind() {
    final newPosition = currentPosition.value - Duration(seconds: 10);
    seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void forward() {
    final newPosition = currentPosition.value + Duration(seconds: 10);
    seek(newPosition > totalDuration.value ? totalDuration.value : newPosition);
  }

  // Format Duration to String
  String formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void openPlayer() {
    Get.to(() => PlayerPage());
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void addToQueue(Audiofile audio) {
  queue.add(audio);
  Get.snackbar("Added to Queue", "${audio.title} has been added to the queue.",
      snackPosition: SnackPosition.BOTTOM);
}

void clearQueue() {
  queue.clear();
  Get.snackbar("Queue Cleared", "All songs have been removed from the queue.",
      snackPosition: SnackPosition.BOTTOM);
}

}
