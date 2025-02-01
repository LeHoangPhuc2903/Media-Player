import 'media_file.dart';

class AudioFile extends MediaFile {
  final String artist;    // Nghệ sĩ
  final String album;     // Album
  final String? genre;    // Thể loại nhạc (nếu có)
  final String? artwork;  // Hình ảnh album (URL hoặc path)

  AudioFile({
    required super.path,
    required super.title,
    required super.duration,
    required super.fileType,
    required this.artist,
    required this.album,
    this.genre,
    this.artwork,
  });

  @override
  String toString() {
    return 'AudioFile(title: $title, artist: $artist, album: $album, duration: $duration)';
  }
}


AudioFile parseAudioMetadata(Map<String, dynamic> metadata) {
  return AudioFile(
    path: metadata['path'] ?? '',
    title: metadata['title'] ?? 'Unknown Title',
    duration: metadata['duration'] ?? '0:00',
    fileType: metadata['fileType'] ?? 'audio',
    artist: metadata['artist'] ?? 'Unknown Artist',
    album: metadata['album'] ?? 'Unknown Album',
    genre: metadata['genre'], // Có thể null
    artwork: metadata['artwork'], // Có thể null
  );
}
