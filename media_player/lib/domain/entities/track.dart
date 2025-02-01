class Track {
  final String title;
  final String subtitle;
  final String path;

  Track({
    required this.title,
    required this.subtitle,
    required this.path,
  });

  static Future<Track?> fromJson(data) async {
    // Add your JSON parsing logic here
    return null; // or return a Track instance
  }
}
