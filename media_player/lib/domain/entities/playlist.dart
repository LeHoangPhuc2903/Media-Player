import 'media.dart';

class Playlist {
  final String id;              // ID duy nhất cho playlist
  final String name;            // Tên playlist
  final List<Media> mediaFiles; // Danh sách các file trong playlist

  Playlist({
    required this.id,
    required this.name,
    required this.mediaFiles,
  });

  @override
  String toString() {
    return 'Playlist(name: $name, media count: ${mediaFiles.length})';
  }

  static Future<List<Playlist>> fromJson(item) async {
    // Implement your JSON parsing logic here
    // For now, returning an empty list as a placeholder
    return [];
  }
}
