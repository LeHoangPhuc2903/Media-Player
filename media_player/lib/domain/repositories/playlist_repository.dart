import 'package:media_player/domain/entities/playlist.dart';

abstract class PlaylistRepository {
  Future<List<Playlist>> getAllPlaylists();
  Future<Playlist?> getPlaylistById(String id);

  Future<Playlist> createNewPlaylist(String name, {required List<String> audioIds});
  Future<Playlist> updatePlaylist(Playlist playlist);
  Future<void> deletePlaylist(String id);

  Future<Playlist> addAudioToPlaylist(String playlistId, String audioId);
  Future<Playlist> removeAudioFromPlaylist(String playlistId, String audioId);
}