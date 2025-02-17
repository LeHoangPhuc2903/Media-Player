import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'dart:io';

Future<void> readAudioMetadata(String filePath) async {
  File file = File(filePath);
  try {
    final metadata = readMetadata(file);

    print('🎵 Title: ${metadata.title}');
    print('🎤 Artist: ${metadata.artist}');
    print('📀 Album: ${metadata.album}');
    print('⏱ Duration: ${metadata.duration} seconds');
  } catch (e) {
    print('⚠️ Error reading metadata: $e');
  }
}
