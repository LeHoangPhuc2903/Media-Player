class Media {
  final String path;      // Đường dẫn file
  final String title;     // Tên file hoặc tiêu đề
  final String duration;  // Thời lượng file (hh:mm:ss)
  final String type;      // Loại file (audio, video, etc.)

  Media({
    required this.path,
    required this.title,
    required this.duration,
    required this.type,
  });

  @override
  String toString() {
    return 'Media(title: $title, duration: $duration, type: $type)';
  }
}
