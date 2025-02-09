class Playlist {
  final String id;              
  final String name;            
  final List<String> audioIds;  
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
