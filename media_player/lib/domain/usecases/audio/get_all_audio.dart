import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/domain/repositories/audio_repository.dart';

class GetAllAudio {
  final AudioRepository repository;

  GetAllAudio(this.repository);

  Future<List<Audiofile>> call() async {
    return await repository.getAllAudioFiles();
  }
}