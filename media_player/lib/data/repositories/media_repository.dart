import 'dart:io';
import 'package:media_player/domain/entities/track.dart';

class MediaRepository {
  // Hàm quét thư mục và trả về danh sách bài hát
  Future<List<Track>> fetchSongs(String directoryPath) async {
    final directory = Directory(directoryPath);

    if (!await directory.exists()) {
      return [];
    }

    final files = directory.listSync(recursive: true).whereType<File>().where(
      (file) {
        // Lọc các file có định dạng nhạc
        final extensions = ['.mp3', '.wav', '.aac'];
        return extensions.any((ext) => file.path.endsWith(ext));
      },
    );

    // Map các file thành danh sách Song
    return files.map((file) {
      final fileName = file.path.split('/').last;
      return Track(
        title: fileName.split('.').first,
        subtitle: "Unknown Artist", // Có thể cập nhật nếu lấy được metadata
        path: file.path,
      );
    }).toList();
  }
}
