import 'package:media_player/data/datasources/mock_data.dart';
import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/domain/repositories/playlist_repository.dart';

class CreateNewPlaylist {
  final PlaylistRepository _playlistRepository;

  CreateNewPlaylist(this._playlistRepository);

  Future<Playlist> call(String name) async {
    
    return await _playlistRepository.createNewPlaylist(name);
  }
}

class UpdatePlaylist {
  final PlaylistRepository _playlistRepository;

  UpdatePlaylist(this._playlistRepository);

  Future<Playlist> call(Playlist playlist) async { 
    return _playlistRepository.updatePlaylist(playlist);
  }
}

class DeletePlaylist {
  final PlaylistRepository _playlistRepository;

  DeletePlaylist(this._playlistRepository);

  Future<void> call(String id) async {
    return _playlistRepository.deletePlaylist(id);
  }
}

class GetAllPlaylist {
  final PlaylistRepository _playlistRepository;

  GetAllPlaylist(this._playlistRepository);

  Future<List<Playlist>> call() async {
    return _playlistRepository.getAllPlaylists();
  }
}

class GetPlaylistById {
  final PlaylistRepository _playlistRepository;

  GetPlaylistById(this._playlistRepository);

  Future<Playlist?> call(String id) async {
    return await _playlistRepository.getPlaylistById(id);
  }
}

class AddAudio {  
  final PlaylistRepository _playlistRepository;

  AddAudio(this._playlistRepository);

  Future<void> call(String playlistId, String audioId) async {
    await _playlistRepository.addAudioToPlaylist(playlistId, audioId);
  }
}

class RemoveAudio {
  final PlaylistRepository _playlistRepository;

  RemoveAudio(this._playlistRepository);

  Future<Playlist> call(String playlistId, String audioId) async {
    return _playlistRepository.removeAudioFromPlaylist(playlistId, audioId);
  }
}