import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/domain/usecases/playlist/playlist_controller.dart';

class PlaylistViewModel extends ChangeNotifier {
  final CreateNewPlaylist createNewPlaylist;
  final GetAllPlaylist getAllPlaylist;
  final UpdatePlaylist updatePlaylist;
  final DeletePlaylist deletePlaylist;
  final GetPlaylistById getPlaylistById;
  final AddAudio addAudio;
  final RemoveAudio removeAudio;
  

  PlaylistViewModel({
    required this.createNewPlaylist,
    required this.getAllPlaylist,
    required this.updatePlaylist,
    required this.deletePlaylist,
    required this.getPlaylistById,
    required this.addAudio,
    required this.removeAudio,
  });

  List<Playlist> _playlists = [];
  List<Playlist> get playlists => _playlists;

  Future<void> createPlaylist(String name) async {
    final newPlaylist = await createNewPlaylist(name);
    _playlists.add(newPlaylist);
    notifyListeners();
  }

  Future<void> updateExistingPlaylist(Playlist playlist) async {
    final updatedPlaylist = await updatePlaylist(playlist);
    final index = _playlists.indexWhere((p) => p.id == playlist.id);
    if (index != -1) {
      _playlists[index] = updatedPlaylist;
      notifyListeners();
    }
  }

  Future<void> deleteExistingPlaylist(String id) async {
    await deletePlaylist(id);
    _playlists.removeWhere((playlist) => playlist.id == id);
    notifyListeners();
  }

  Future<void> addAudioToPlaylist(String playlistId, String audioId) async {
    await addAudio(playlistId, audioId);
    final playlist = await getPlaylistById(playlistId);
    if (playlist != null) {
      final index = _playlists.indexWhere((p) => p.id == playlistId);
      if (index != -1) {
        _playlists[index] = playlist;
        notifyListeners();
      }
    }
  }

  Future<void> removeAudioFromPlaylist(String playlistId, String audioId) async {
    await removeAudio(playlistId, audioId);
    final playlist = await getPlaylistById(playlistId);
    if (playlist != null) {
      final index = _playlists.indexWhere((p) => p.id == playlistId);
      if (index != -1) {
        _playlists[index] = playlist;
        notifyListeners();
      }
    }
  }
}
