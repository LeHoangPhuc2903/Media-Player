import 'package:media_player/data/datasources/local_audios.dart';
import 'package:media_player/data/models/playlist_model.dart';
import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/domain/repositories/playlist_repository.dart';

class LocalPlaylistRepository implements PlaylistRepository {
  final LocalPlaylistDataSource localDataSource;

  LocalPlaylistRepository(this.localDataSource);

  @override
  Future<List<Playlist>> getAllPlaylists() async {
    return await localDataSource.getAllPlaylists();
  }

  @override
  Future<Playlist?> getPlaylistById(String id) async {
    return await localDataSource.getPlaylistById(id);
  }

  @override
  Future<Playlist> createNewPlaylist(String name) async {
    return await localDataSource.createNewPlaylist(name);
  }

  @override
Future<Playlist> updatePlaylist(Playlist playlist) async {
  final updatedPlaylist = PlaylistModel(
    id: playlist.id,
    name: playlist.name,
    audioIds: playlist.audioIds,
  );

  final result = await localDataSource.updatePlaylist(updatedPlaylist);
  return Playlist(
    id: result.id,
    name: result.name,
    audioIds: result.audioIds,
  );
}

  @override
  Future<void> deletePlaylist(String id) async {
    return await localDataSource.deletePlaylist(id);
  }

  @override
  Future<Playlist> addAudioToPlaylist(String playlistId, String audioId) async {
    return await localDataSource.addAudioToPlaylist(playlistId, audioId);
  }

  @override
  Future<Playlist> removeAudioFromPlaylist(String playlistId, String audioId) async {
    return await localDataSource.removeAudioFromPlaylist(playlistId, audioId);
  }
}
