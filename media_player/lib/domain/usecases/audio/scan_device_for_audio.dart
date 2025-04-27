import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'dart:convert';
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
      '/storage/emulated/0/Download',
      '/storage/emulated/0/DCIM',
      '/storage/emulated/0/Podcasts',
      ];

      List<Audiofile> audioFiles = [];

      for (String path in searchPaths) {
        Directory dir = Directory(path);
        if (!dir.existsSync()) {
          print("Folder not found: $path");
          continue;
        }

        await for (var file in dir.list(recursive: false, followLinks: false)) {
          if (file is File && file.path.endsWith('.mp3')) {
            String correctPath = file.path.replaceAll("//", "/");
            try {
              if (file.lengthSync() > 0) {
                final metadata = readMetadata(File(correctPath));
                  Uint8List? albumArt;
                  bool hasImage = false;
                  if (metadata.pictures.isNotEmpty) {
                      albumArt = metadata.pictures.first.bytes;
                      hasImage = true;
                  }
                  audioFiles.add(Audiofile(
                  id: md5.convert(utf8.encode(file.path)).toString(),
                  title: metadata.title?.isNotEmpty == true ? metadata.title! : parseTitleFromFilename(file.uri.pathSegments.last),
                  artist: metadata.artist?.isNotEmpty == true ? metadata.artist! : parseArtistFromFilename(file.uri.pathSegments.last),
                  duration: metadata.duration?.inSeconds ?? 0,
                  filePath: correctPath,
                  albumArt: albumArt,
                  hasImage: hasImage,
                  albumName: metadata.album,
                  genre: metadata.genres.isNotEmpty ? metadata.genres.first : null,
                ));
              } else {
                print("⚠️ Skipping empty file or corrupt: $correctPath");
              }
            } catch (e) {
              print("⚠️ Failed to read metadata for: $correctPath. Using filename as fallback.");

              audioFiles.add(Audiofile(
                id: file.path.hashCode.toString(),
                title: parseTitleFromFilename(file.uri.pathSegments.last),
                artist: parseArtistFromFilename(file.uri.pathSegments.last),
                duration: 0,
                filePath: correctPath,
                hasImage: false,
              ));
            }
          }
        }
      }

      if (audioFiles.isNotEmpty) {
        try {
          await repository.saveAudioFiles(audioFiles);
          print("✅ Successfully saved ${audioFiles.length} audio files.");
        } catch (e) {
          print("❌ Failed to save audio files to repository: $e");
        }
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

  String parseTitleFromFilename(String filename) {
  filename = filename.replaceAll(".mp3", "");

  // Pattern: Artist - Title
  final regExpBasic = RegExp(r"^(.*?)\s*-\s*(.*?)$");
  final matchBasic = regExpBasic.firstMatch(filename);
  if (matchBasic != null) {
    return matchBasic.group(2) ?? filename;
  }

  // Fallback to filename if no pattern matched
  return filename;
}

String parseArtistFromFilename(String filename) {
  filename = filename.replaceAll(".mp3", "");

  // Pattern: Artist - Title
  final regExpBasic = RegExp(r"^(.*?)\s*-\s*(.*?)$");
  final matchBasic = regExpBasic.firstMatch(filename);
  if (matchBasic != null) {
    return matchBasic.group(1) ?? "Unknown Artist";
  }
  // Fallback to Unknown Artist
  return "Unknown Artist";
}

}
