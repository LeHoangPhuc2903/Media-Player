import 'package:get/get.dart';
import 'package:media_player/domain/usecases/audio/get_all_audio.dart';
import 'package:media_player/domain/usecases/playlist/playlist_controller.dart';
import 'package:media_player/domain/usecases/audio/scan_device_for_audio.dart';
import 'package:media_player/domain/entities/audiofile.dart';
import 'package:media_player/domain/entities/playlist.dart';

class HomeController extends GetxController {
  final GetAllAudio getAllAudio;
  final GetAllPlaylist getAllPlaylist;
  final ScanDeviceForAudioFiles scanDeviceForAudioFiles;

  HomeController({
    required this.getAllAudio,
    required this.getAllPlaylist,
    required this.scanDeviceForAudioFiles,
  });

  final RxList<Audiofile> audioFiles = <Audiofile>[].obs;
  final RxList<Playlist> playlists = <Playlist>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    scanAndLoadData();
  }

  Future<void> scanAndLoadData() async {
    isLoading.value = true; // Show loading state
    await scanDeviceForAudioFiles.call();
    audioFiles.value = await getAllAudio.call();
    playlists.value = await getAllPlaylist.call();
    isLoading.value = false; // Hide loading state
  }
}
