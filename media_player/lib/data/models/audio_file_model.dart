import 'package:media_player/domain/entities/audiofile.dart';

class AudioFileModel extends Audiofile{
  AudioFileModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.duration,
    required super.filePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'duration': duration,
      'filePath': filePath,
    };
  }

  factory AudioFileModel.fromMap(Map<String, dynamic> map) {
    return AudioFileModel(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      duration: map['duration'],
      filePath: map['filePath'],
    );
  }
}