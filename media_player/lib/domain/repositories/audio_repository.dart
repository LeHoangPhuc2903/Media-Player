import 'package:media_player/domain/entities/audiofile.dart';

abstract class AudioRepository {
  Future<void> scanDeviceForAudioFiles();

  Future<List<Audiofile>> getAllAudioFiles();
  
  Future<Audiofile?> getAudioFileById(String id);

  Future<void> saveAudioFiles(List<Audiofile> audioFiles);

}