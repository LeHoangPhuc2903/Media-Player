import 'package:media_player/domain/entities/playlist.dart';

import '../models/user_model.dart';
import '../models/audio_file_model.dart';

final List<Map<String, String>> banners = [
  {
    'image': 'lib/data/assets/images/adventure.webp',
    'title': 'Adventure Awaits',
    'subtitle': 'EXPLORE',
  },
  {
    'image': 'lib/data/assets/images/dream.webp',
    'title': 'Dreams of Tomorrow',
    'subtitle': 'IMAGINE',
  },
  {
    'image': 'lib/data/assets/images/chill.webp',
    'title': 'Chill Vibes',
    'subtitle': 'RELAX',
  },
];

final List<UserModel> users = [
  UserModel(
    id: '1',
    username: 'John Doe',
    
  ),
  UserModel(
    id: '2',
    username: 'Jane Smith',
    
  ),
];

final List<Playlist> playlists = [
  Playlist(
    id: '1',
    name: 'Echoes of the Night',
    audioIds: ['1', '2', '3'],
  ),
  Playlist(
    id: '2',
    name: 'Party All Night',
    audioIds: ['4', '5', '6'],
  ),
  Playlist(
    id: '3',
    name: 'Chill Time',
    audioIds: ['7', '8', '9'],
  ),
];

final List<AudioFileModel> songs = [
  AudioFileModel(
    id: '1',
    title: 'Song 1',
    artist: 'Artist 1',  
    duration: 180,
    filePath: 'lib/data/assets/song1.mp3',
  ),
  AudioFileModel(
    id: '2',
    title: 'Song 2',
    artist: 'Artist 2',
    filePath: 'lib/data/assets/song2.mp3',
    duration: 200,
    
  ),
  // ...additional songs...
];

final List<Map<String, String>> albums = [
  {
    'title': 'Album 1',
    'image': 'lib/data/assets/images/echo.webp',
    'artist': 'Artist 1',
  },
  {
    'title': 'Album 2',
    'image': 'lib/data/assets/images/party.webp',
    'artist': 'Artist 2',
  },
  {
    'title': 'Album 3',
    'image': 'lib/data/assets/images/chill.webp',
    'artist': 'Artist 3',
  },
];