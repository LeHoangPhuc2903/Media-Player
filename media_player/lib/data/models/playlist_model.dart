import 'package:media_player/domain/entities/playlist.dart';

class PlaylistModel extends Playlist{
  PlaylistModel({
    required super.id,
    required super.name,
    required super.audioIds,
    super.createdDate,
    super.modifiedDate,
  });

  factory PlaylistModel.fromMap(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json['id'],
      name: json['name'],
      audioIds: List<String>.from(json['audioIds']),
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      modifiedDate: json['modifiedDate'] != null ? DateTime.parse(json['modifiedDate']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'audioIds': audioIds,
      'createdDate': createdDate?.toIso8601String(),
      'modifiedDate': modifiedDate?.toIso8601String(),
    };
  }
}