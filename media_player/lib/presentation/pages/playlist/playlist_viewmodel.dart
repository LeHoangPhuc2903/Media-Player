import 'package:get/get.dart';
import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/domain/use_cases/playlist/playlist_controller.dart';

class PlaylistViewModel extends GetxController {
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

  final RxList<Playlist> playlists = <Playlist>[].obs;

  Future<void> createPlaylist(String name, {List<String> audioIds = const []}) async {
    try {
      final newPlaylist = await createNewPlaylist(name, audioIds: audioIds);
      playlists.add(newPlaylist);
      playlists.refresh();
      Get.snackbar("Success", "Playlist '$name' created!");
    } catch (e) {
      print("Error creating playlist: $e");
      Get.snackbar("Error", "Failed to create playlist.");
    }
  }

  Future<void> updateExistingPlaylist(Playlist playlist) async {
    try {
      final updatedPlaylist = await updatePlaylist(playlist);
      final index = playlists.indexWhere((p) => p.id == playlist.id);
      if (index != -1) {
        playlists[index] = updatedPlaylist;
        playlists.refresh();
        Get.snackbar("Success", "Playlist '${playlist.name}' updated!");
      }
    } catch (e) {
      print("Error updating playlist: $e");
      Get.snackbar("Error", "Failed to update playlist.");
    }
  }

  Future<void> deleteExistingPlaylist(String id) async {
    try {
      await deletePlaylist(id);
      playlists.removeWhere((playlist) => playlist.id == id);
      playlists.refresh();
      Get.snackbar("Success", "Playlist deleted!");
    } catch (e) {
      print("Error deleting playlist: $e");
      Get.snackbar("Error", "Failed to delete playlist.");
    }
  }

  Future<void> addAudioToPlaylist(String playlistId, String audioId) async {
    try {
      await addAudio(playlistId, audioId);
      final playlist = await getPlaylistById(playlistId);
      if (playlist != null) {
        final index = playlists.indexWhere((p) => p.id == playlistId);
        if (index != -1) {
          playlists[index] = playlist;
          playlists.refresh();
          Get.snackbar("Success", "Audio added to playlist!");
        }
      }
    } catch (e) {
      print("Error adding audio to playlist: $e");
      Get.snackbar("Error", "Failed to add audio to playlist.");
    }
  }

  Future<void> removeAudioFromPlaylist(String playlistId, String audioId) async {
    try {
      await removeAudio(playlistId, audioId);
      final playlist = await getPlaylistById(playlistId);
      if (playlist != null) {
        final index = playlists.indexWhere((p) => p.id == playlistId);
        if (index != -1) {
          playlists[index] = playlist;
          playlists.refresh();
          Get.snackbar("Success", "Audio removed from playlist!");
        }
      }
    } catch (e) {
      print("Error removing audio from playlist: $e");
      Get.snackbar("Error", "Failed to remove audio from playlist.");
    }
  }
}
