import 'package:media_player/data/models/audio_file_model.dart';
import 'package:media_player/domain/entities/playlist.dart';

class PlaylistModel extends Playlist {
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
      audioIds: json['audioIds'] != null ? List<String>.from(json['audioIds']) : [],
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      modifiedDate: json['modifiedDate'] != null ? DateTime.parse(json['modifiedDate']) : null,
    );
  }

  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': name,
    'createdDate': createdDate?.toIso8601String(),
    'modifiedDate': modifiedDate?.toIso8601String(),
  };
}


  PlaylistModel copyWith({
    String? id,
    String? name,
    List<String>? audioIds,
    DateTime? createdDate,
    DateTime? modifiedDate, required List<AudioFileModel> audioFiles,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      audioIds: audioIds ?? this.audioIds,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
    );
  }
}
