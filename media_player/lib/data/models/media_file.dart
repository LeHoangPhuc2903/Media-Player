class MediaFile {
  final String path;      // Đường dẫn file
  final String title;     // Tên file hoặc tiêu đề
  final String duration;  // Thời lượng file (hh:mm:ss)
  final String fileType;  // Định dạng file (audio, video, etc.)

  MediaFile({
    required this.path,
    required this.title,
    required this.duration,
    required this.fileType,
  });

  @override
  String toString() {
    return 'MediaFile(title: $title, duration: $duration, fileType: $fileType)';
  }
}
