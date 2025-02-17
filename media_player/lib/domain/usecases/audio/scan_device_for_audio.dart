import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/domain/repositories/audio_repository.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';

class ScanDeviceForAudioFiles {
  final AudioRepository repository;

  ScanDeviceForAudioFiles(this.repository);

  Future<void> call() async {
    try {
      if (await _requestStoragePermission() == false) {
        print("Storage permission denied.");
        return;
      }

      List<String> searchPaths = [
        '/storage/emulated/0/Music',
        '/storage/emulated/0/Download'
      ];

      List<Audiofile> audioFiles = [];

      for (String path in searchPaths) {
        Directory dir = Directory(path);
        if (!dir.existsSync()) {
          print("Folder not found: $path");
          continue;
        }

        for (var file in dir.listSync()) {
          if (file is File && file.path.endsWith('.mp3')) {
            String correctPath = file.path.replaceAll("//", "/");

            try {
              final metadata = readMetadata(File(correctPath));
              print("🎵 Found audio file: $correctPath");

              audioFiles.add(Audiofile(
                id: file.path.hashCode.toString(),
                title: metadata.title ?? file.uri.pathSegments.last.replaceAll('.mp3', ''),
                artist: metadata.artist ?? "Unknown Artist",
                //album: metadata.album ?? "Unknown Album",
                duration: metadata.duration?.inSeconds ?? 0,
                filePath: correctPath,
              ));
            } catch (e) {
              print("⚠️ Failed to read metadata for: $correctPath");
            }
          }
        }
      }

      if (audioFiles.isNotEmpty) {
        await repository.saveAudioFiles(audioFiles);
        print("✅ Saved ${audioFiles.length} audio files with metadata.");
      } else {
        print("⚠️ No MP3 files found.");
      }

    } catch (e) {
      print("❌ Error scanning for audio files: $e");
    }
  }

  
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Android 13+ (API 33+)
      if (await Permission.audio.request().isGranted) {
        print("Audio files access granted.");
        return true;
      }

      // Android 10+ (API 29-32)
      if (await Permission.manageExternalStorage.request().isGranted) {
        print("Manage external storage granted.");
        return true;
      }

      // Older Android versions
      if (await Permission.storage.request().isGranted) {
        print("✅ Storage permission granted.");
        return true;
      }

      print("Storage permission denied.");
      return false;
    }
    return true;
  }

}
