import 'package:get/get.dart';
import 'package:media_player/data/datasources/local_data_impl.dart';
import 'package:media_player/domain/usecases/audio/get_all_audio.dart';
import 'package:media_player/domain/usecases/playlist/playlist_controller.dart';
import 'package:media_player/domain/usecases/audio/scan_device_for_audio.dart';
import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/domain/entities/playlist.dart';

class HomeController extends GetxController {
  final GetAllAudio getAllAudio;
  final GetAllPlaylist getAllPlaylist;
  final GetPlaylistById getPlaylistById;
  final CreateNewPlaylist createNewPlaylist;
  final DeletePlaylist deletePlaylist;
  final ScanDeviceForAudioFiles scanDeviceForAudioFiles;
  

  HomeController({
    required this.getAllAudio,
    required this.getAllPlaylist,
    required this.getPlaylistById,
    required this.createNewPlaylist,
    required this.deletePlaylist,
    required this.scanDeviceForAudioFiles,
  });

  final RxList<Audiofile> audioFiles = <Audiofile>[].obs;
  final RxList<Playlist> playlists = <Playlist>[].obs;
  final RxBool isLoading = true.obs;

  // Variables for playlist creation
  final RxBool isCreatingPlaylist = false.obs;
  final RxString newPlaylistName = ''.obs;
  final RxList<Audiofile> selectedAudios = <Audiofile>[].obs;

  @override
  void onInit() {
    super.onInit();
    scanAndLoadData();
  }

  Future<void> scanAndLoadData() async {
  try {
    isLoading.value = true;
    await scanDeviceForAudioFiles.call();
    audioFiles.assignAll(await getAllAudio.call());

    final updatedPlaylists = await getAllPlaylist.call();

    for (var playlist in updatedPlaylists) {
      playlist.audioFiles = audioFiles
          .where((audio) => playlist.audioIds.contains(audio.id))
          .toList();
      print("🎵 Playlist '${playlist.name}' has audios: ${playlist.audioFiles.map((a) => a.title).toList()}");
    }

    playlists.assignAll(updatedPlaylists);
  } catch (e) {
    print("Error loading data: $e");
  } finally {
    isLoading.value = false;
  }
}

  // Toggle the Create Playlist Section
  void toggleCreatePlaylistSection() {
    isCreatingPlaylist.value = !isCreatingPlaylist.value;
    if (!isCreatingPlaylist.value) {
      newPlaylistName.value = '';
      selectedAudios.clear();
    }
  }

  // Select an audio to add the selected list to add to the playlist
  void addAudioToSelectedList(Audiofile audio) {
    if (!selectedAudios.contains(audio)) {
      selectedAudios.add(audio);
    }
  }

  // Remove an audio preview from an on selected audios for the playlist 
  void removeAudioFromSelectedList(Audiofile audio) {
    selectedAudios.remove(audio);
  }

  Future<void> createNewPlaylistWithAudios() async {
  if (newPlaylistName.value.trim().isEmpty) {
    Get.snackbar("Error", "Playlist name cannot be empty!");
    return;
  }

  try {
    final audioIds = selectedAudios.map((audio) => audio.id).toList();

    print("🎵 Selected audio IDs for playlist: $audioIds");

    await createNewPlaylist.call(newPlaylistName.value.trim(), audioIds: audioIds);
    
    // Refresh playlists to reflect the new one
    await scanAndLoadData();

    Get.snackbar(
      "Success",
      "Playlist '${newPlaylistName.value}' created with ${audioIds.length} audios!",
      snackPosition: SnackPosition.BOTTOM,
    );

    
    newPlaylistName.value = '';
    selectedAudios.clear();

  } catch (e) {
    print("Error creating playlist: $e");
    Get.snackbar("Error", "Failed to create playlist.");
  }
}

  // Refresh playlists from storage
  Future<void> refreshPlaylists() async {
    playlists.assignAll(await getAllPlaylist.call());
  }

  /*Future<Playlist?> getToPlaylistById(String id) async {
  return await getPlaylistById.call(id);
}
*/
Future<Playlist?> getPlaylistByIdWithAudios(String id) async {
  try {
    final playlist = await getPlaylistById.call(id);
    if (playlist == null) return null;

    // Match audioFiles based on audioIds
    final matchingAudios = audioFiles
        .where((audio) => playlist.audioIds.contains(audio.id))
        .toList();

    playlist.audioFiles = matchingAudios;
    return playlist;
  } catch (e) {
    print("❌ Error loading playlist with audios: $e");
    return null;
  }
}


Future<void> deleteExistingPlaylist(String id) async {
  try {
    await deletePlaylist.call(id);
    await scanAndLoadData();
    Get.snackbar("Deleted", "Playlist has been deleted successfully!");
  } catch (e) {
    print("❌ Error deleting playlist: $e");
    Get.snackbar("Error", "Failed to delete playlist.");
  }
}

}
