import 'dart:io';

import 'package:media_player/data/datasources/local.dart';
import 'package:media_player/data/models/audio_file_model.dart';
import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/domain/repositories/audio_repository.dart';
import 'package:path_provider/path_provider.dart';

class LocalAudioRepository implements AudioRepository {
  final LocalAudioDataSource localDataSource;

  LocalAudioRepository(this.localDataSource);

  @override
  Future<List<Audiofile>> scanDeviceForAudioFiles() async {
    return await localDataSource.scanDeviceForAudioFiles();
  }

  @override
  Future<List<Audiofile>> getAllAudioFiles() async {
  Directory? musicDir = await getExternalStorageDirectory();
  if (musicDir == null) return [];

  String audioFolderPath = "${musicDir.path}/Music";

  List<Audiofile> audioFiles = await localDataSource.getAllAudioFiles();
  return audioFiles.map((audio) {
    return Audiofile(
      id: audio.id,
      title: audio.title,
      artist: audio.artist,
      duration: audio.duration,
      filePath: audio.filePath,
    );
  }).toList();
}

  @override
  Future<Audiofile?> getAudioFileById(String id) async {
    return await localDataSource.getAudioFileById(id);
  }

  @override
  Future<void> saveAudioFiles(List<Audiofile> audioFiles) async {
    await localDataSource.saveAudioFiles(
      audioFiles.map((audio) => AudioFileModel(
        id: audio.id,
        title: audio.title,
        artist: audio.artist,
        duration: audio.duration,
        filePath: audio.filePath,
      )).toList(),
    );
  }
}
