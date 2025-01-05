import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer player = AudioPlayer();

  Future<void> play(String filePath) async {
    await player.setFilePath(filePath);
    player.play();
  }

  Future<void> pause() async {
    player.pause();
  }
}
