import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/domain/repositories/audio_repository.dart';

class GetAudioById {
  final AudioRepository repository;

  GetAudioById(this.repository);

  Future<Audiofile?> call(String id) async {
  try {
    return await repository.getAudioFileById(id);
  } catch (e) {
    print("❌ Error fetching audio by ID $id: $e");
    return null;
  }
}

}