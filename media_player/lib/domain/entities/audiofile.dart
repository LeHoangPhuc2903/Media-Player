import 'dart:typed_data';

class Audiofile {
  final String id;        
  final String title;     
  final String artist;         
  final int duration;  
  final String filePath;
  final Uint8List? albumArt;
  final String? albumName;
  final String? genre;
  final bool hasImage;    
  
  
  Audiofile({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.filePath,
    this.albumArt,
    this.albumName,
    this.genre,
    this.hasImage = false,
  });

}
