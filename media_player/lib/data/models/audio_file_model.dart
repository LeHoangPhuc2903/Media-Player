import 'package:media_player/domain/entities/audiofile.dart';

class AudioFileModel extends Audiofile{
  AudioFileModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.duration,
    required super.filePath,
    super.albumArt,
    super.albumName,
    super.genre,
    super.hasImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'title': title,
      'artist': artist,
      'duration': duration,
      'filePath': filePath,
      'albumArt': albumArt,
      'albumName': albumName,
      'genre': genre,
      'hasImage': hasImage ? 1 : 0,
    };
  }

  factory AudioFileModel.fromMap(Map<String, dynamic> map) {
    return AudioFileModel(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      duration: map['duration'],
      filePath: map['filePath'],
      albumArt: map['albumArt'],
      albumName: map['albumName'],
      genre: map['genre'],
      hasImage: (map['hasImage'] ?? 0) == 1,
    );
  }
}