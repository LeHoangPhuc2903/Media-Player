import 'package:media_player/data/repositories/spotify_repository.dart';

class PlayTrackUseCase {
  final SpotifyRepository repository;

  PlayTrackUseCase(this.repository);

  Future<void> execute(String trackUri) async {
    await repository.playTrack(trackUri);
  }
}
