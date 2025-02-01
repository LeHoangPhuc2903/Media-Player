import 'package:get/get.dart';
//import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/domain/usecases/get_playlists_usecase.dart';
import 'package:media_player/test_api/model.dart';

class PlaylistViewModel extends GetxController {
  final GetPlaylistsUseCase getPlaylistsUseCase;

  var playlists = <Playlist>[].obs;

  PlaylistViewModel(this.getPlaylistsUseCase);

  Future<void> fetchPlaylists() async {
    playlists.value = await getPlaylistsUseCase.execute();
  }
}
