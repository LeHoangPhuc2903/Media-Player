import 'package:media_player/domain/entities/audiofile.dart';

class Playlist {
  final String id;              
  final String name;            
  late final List<String> audioIds;
  List<Audiofile> audioFiles = []; 
  final DateTime? createdDate;
  final DateTime? modifiedDate;


  Playlist({
    required this.id,
    required this.name,
    required this.audioIds,
    this.createdDate,
    this.modifiedDate,
  });

}
