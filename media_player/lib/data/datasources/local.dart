import 'package:media_player/data/models/audio_file_model.dart';
import 'package:media_player/data/models/playlist_model.dart';
import 'package:media_player/data/models/user_model.dart';
import 'package:media_player/domain/entities/playlist.dart';

abstract class LocalAudioDataSource {
  Future<List<AudioFileModel>> scanDeviceForAudioFiles();
  Future<List<AudioFileModel>> getAllAudioFiles();
  Future<AudioFileModel?> getAudioFileById(String id);
  Future<void> saveAudioFiles(List<AudioFileModel> audioFiles);

}

abstract class LocalPlaylistDataSource {
  Future<List<PlaylistModel>> getAllPlaylists();
  Future<PlaylistModel?> getPlaylistById(String id);
  Future<PlaylistModel> createNewPlaylist(String name);
  Future<PlaylistModel> updatePlaylist(PlaylistModel playlist);
  Future<void> deletePlaylist(String id);
  Future<PlaylistModel> addAudioToPlaylist(String playlistId, String audioId);
  Future<PlaylistModel> removeAudioFromPlaylist(String playlistId, String audioId);
}

abstract class LocalUserDataSource {
  Future<UserModel?> getCurrentUser();
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser(String id);
}