import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/domain/entities/track.dart';
import 'spotify_repository.dart';
import 'package:media_player/test_api/model.dart';

class SpotifyRepositoryImpl implements SpotifyRepository {
  final String accessToken;

  SpotifyRepositoryImpl(this.accessToken);

  @override
  Future<List<Playlist>> getPlaylists() async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me/playlists'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['items'];
      return data.map<Playlist>((item) => Playlist.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch playlists');
    }
  }

  @override
  Future<Track?> getCurrentTrack() async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me/player/currently-playing'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Track.fromJson(data['item']);
    } else {
      return null;
    }
  }

  @override
  Future<void> playTrack(String trackUri) async {
    final response = await http.put(
      Uri.parse('https://api.spotify.com/v1/me/player/play'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({'uris': [trackUri]}),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to play track');
    }
  }
}
