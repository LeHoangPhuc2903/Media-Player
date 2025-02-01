import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class PlaylistViewModel extends GetxController {
  final String accessToken;

  PlaylistViewModel(this.accessToken);

  var playlists = <Playlist>[].obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchPlaylists() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/browse/featured-playlists'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        playlists.value = (data['playlists']['items'] as List)
            .map((item) => Playlist.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load playlists: ${response.body}');
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}