//import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/domain/entities/track.dart';
import 'package:media_player/test_api/model.dart';

abstract class SpotifyRepository {
  Future<List<Playlist>> getPlaylists();
  Future<Track?> getCurrentTrack();
  Future<void> playTrack(String trackUri);
}
