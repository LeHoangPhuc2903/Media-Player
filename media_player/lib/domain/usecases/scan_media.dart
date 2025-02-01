import 'package:media_player/domain/entities/media.dart';
import 'package:media_player/data/repositories/media_repository.dart';


class ScanMedia {
  final MediaRepository repository;

  ScanMedia(this.repository);

  Future<List<Media>> execute() async {
    final audioFiles = await repository.fetchAudioFiles();

    // Chuyển đổi `AudioFile` thành `Media`
    return audioFiles.map((audio) {
      return Media(
        path: audio.path,
        title: audio.title,
        duration: audio.duration,
        type: 'audio',
      );
    }).toList();
  }

 
}





