import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpotifyAuth {
  final String clientId = '9bd096fd1439483eb87fc4e0976564ea';
  final String clientSecret = '6b0ef04caf0649b3902ab7195ba56279';
  final String redirectUri = 'music-app://callback';

  Future<String?> authenticate() async {
    final authUrl = Uri.https('accounts.spotify.com', '/authorize', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'scope': 'user-read-playback-state user-modify-playback-state',
    });

    try {
      final result = await FlutterWebAuth.authenticate(
          url: authUrl.toString(), callbackUrlScheme: 'music-app');
      final code = Uri.parse(result).queryParameters['code'];
      return code;
    } catch (e) {
      print('Error during authentication: $e');
      return null;
    }
  }

  Future<String?> getAccessToken(String code) async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['access_token'];
    } else {
      print('Failed to get access token: ${response.body}');
      return null;
    }
  }
}
