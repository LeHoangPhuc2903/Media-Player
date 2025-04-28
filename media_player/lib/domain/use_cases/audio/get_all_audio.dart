import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/domain/repositories/audio_repository.dart';

class GetAllAudio {
  final AudioRepository repository;

  GetAllAudio(this.repository);

  Future<List<Audiofile>> call() async {
  try {
    return await repository.getAllAudioFiles();
  } catch (e) {
    print("❌ Error getting all audio files: $e");
    return [];
  }
}
}