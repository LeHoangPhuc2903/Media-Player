import 'package:media_player/data/repositories/spotify_repository.dart';
//import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/test_api/model.dart';

class GetPlaylistsUseCase {
  final SpotifyRepository repository;

  GetPlaylistsUseCase(this.repository);

  Future<List<Playlist>> execute() async {
    return await repository.getPlaylists();
  }
}
