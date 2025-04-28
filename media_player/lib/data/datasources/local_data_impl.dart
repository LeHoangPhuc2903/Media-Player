import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'package:media_player/data/models/audio_file_model.dart';
import 'package:media_player/data/models/playlist_model.dart';
import 'package:media_player/data/models/user_model.dart';
import 'package:media_player/data/datasources/local_data.dart';

class LocalDatabase {
  static Database? _database;
  
  static final LocalDatabase _instance = LocalDatabase._internal();

  LocalDatabase._internal();

  factory LocalDatabase() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
  final path = join(await getDatabasesPath(), 'media_player.db');
  print("Database Path: $path");
  return openDatabase(
    path,
    version: 4,
    onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    },
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE audio_files (
          id TEXT PRIMARY KEY,
          title TEXT,
          artist TEXT,
          duration INTEGER,
          filePath TEXT,
          albumArt BLOB,
          albumName TEXT,
          genre TEXT,
          hasImage INTEGER DEFAULT 0
        )
      ''');

      await db.execute('''
        CREATE TABLE playlists (
          id TEXT PRIMARY KEY,
          name TEXT,
          createdDate TEXT,
          modifiedDate TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE playlist_audio (
          playlist_id TEXT,
          audio_id TEXT,
          PRIMARY KEY (playlist_id, audio_id),
          FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
          FOREIGN KEY (audio_id) REFERENCES audio_files(id) ON DELETE CASCADE
        )
      ''');

      await db.execute('''
        CREATE TABLE users (
          id TEXT PRIMARY KEY,
          username TEXT
        )
      ''');
    },
  );
}

Future<void> printAllDatabaseData() async {
    final db = await database;

    final audioFiles = await db.query('audio_files');
    print("🎵 Audio Files: $audioFiles");

    final playlists = await db.query('playlists');
    print("📂 Playlists: $playlists");

    final playlistAudioLinks = await db.query('playlist_audio');
    print("🔗 Playlist-Audio Links: $playlistAudioLinks");
  }

}

class LocalAudioDataSourceImpl implements LocalAudioDataSource {
  final LocalDatabase dbInstance;

  LocalAudioDataSourceImpl(this.dbInstance);

  @override
  Future<List<AudioFileModel>> scanDeviceForAudioFiles() async {
    final db = await dbInstance.database;
    final result = await db.query('audio_files');
    return result.map((e) => AudioFileModel.fromMap(e)).toList();
    
  }

  @override
  Future<List<AudioFileModel>> getAllAudioFiles() async {
    final db = await dbInstance.database;
    final result = await db.query('audio_files');
    return result.map((e) => AudioFileModel.fromMap(e)).toList();
  }

  @override
  Future<AudioFileModel?> getAudioFileById(String id) async {
    final db = await dbInstance.database;
    final result = await db.query('audio_files', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return AudioFileModel.fromMap(result.first);
  }

  @override
Future<void> saveAudioFiles(List<AudioFileModel> audioFiles) async {
  final db = await dbInstance.database;

  for (var file in audioFiles) {
    // Check if the audio file already exists
    final existing = await db.query(
      'audio_files',
      where: 'id = ?',
      whereArgs: [file.id],
    );

    if (existing.isEmpty) {
      await db.insert('audio_files', file.toMap());
      print("✅ Inserted new audio: ${file.title}");
    } else {
      print("⚠️ Audio already exists: ${file.title}");
    }
  }
}
}

class LocalPlaylistDataSourceImpl implements LocalPlaylistDataSource {
  final LocalDatabase dbInstance;

  LocalPlaylistDataSourceImpl(this.dbInstance);

  @override
Future<List<PlaylistModel>> getAllPlaylists() async {
  final db = await dbInstance.database;
  final playlists = await db.query('playlists');

  return Future.wait(playlists.map((playlistData) async {
    // Fetch linked audio IDs
    final audioResult = await db.query(
      'playlist_audio',
      columns: ['audio_id'],
      where: 'playlist_id = ?',
      whereArgs: [playlistData['id']],
    );

    final audioIds = audioResult.map((e) => e['audio_id'].toString()).toList();
    print("🔗 Playlist ${playlistData['id']} has audios: $audioIds");

    // Fetch audio files with corrected query
    final audioFiles = audioIds.isNotEmpty
        ? await db.query(
            'audio_files',
            where: 'id IN (${List.filled(audioIds.length, '?').join(', ')})',
            whereArgs: audioIds,
          )
        : [];

    final audios = audioFiles.map((audio) => AudioFileModel.fromMap(audio)).toList();
    print("🎵 Playlist ${playlistData['id']} loaded audios: ${audios.map((a) => a.title).toList()}");

    final playlist = PlaylistModel.fromMap(playlistData);
    playlist.audioFiles = audios;

    return playlist.copyWith(audioIds: audioIds, audioFiles: audios);
  }));
}

  @override
Future<PlaylistModel?> getPlaylistById(String id) async {
  final db = await dbInstance.database;

  final playlistResult = await db.query('playlists', where: 'id = ?', whereArgs: [id]);
  if (playlistResult.isEmpty) return null;

  final audioResult = await db.query(
    'playlist_audio',
    columns: ['audio_id'],
    where: 'playlist_id = ?',
    whereArgs: [id],
  );

  final audioIds = audioResult.map((e) => e['audio_id'] as String).toList();
  final audios = await db.query(
      'audio_files',
      where: 'id IN (${audioIds.map((_) => '?').join(', ')})',
      whereArgs: audioIds,
    );

    final audioFiles = audios.map((audioData) => AudioFileModel.fromMap(audioData)).toList();

  final playlist = PlaylistModel.fromMap(playlistResult.first);
  return playlist.copyWith(audioIds: audioIds, audioFiles: audioFiles);
}
 
@override
Future<PlaylistModel> createNewPlaylist(String name, {List<String> audioIds = const []}) async {
  final db = await dbInstance.database;
  final uuid = Uuid();
  final newPlaylistId = uuid.v4();

  final newPlaylist = PlaylistModel(
    id: newPlaylistId,
    name: name,
    audioIds: audioIds,
    createdDate: DateTime.now(),
    modifiedDate: DateTime.now(),
  );

  await db.transaction((txn) async {
    // ✅ Insert the playlist first
    await txn.insert('playlists', newPlaylist.toMap());
    print("✅ Playlist created: ${newPlaylist.toMap()}");

    // ✅ Now link audio files, but with detailed logging
    for (var audioId in audioIds) {
      try {
        final audioIdStr = audioId.toString();

        // Check if the audio ID actually exists in the audio_files table
        final audioExists = await txn.query(
          'audio_files',
          where: 'id = ?',
          whereArgs: [audioIdStr],
        );

        if (audioExists.isNotEmpty) {
          await txn.insert('playlist_audio', {
            'playlist_id': newPlaylist.id,
            'audio_id': audioIdStr,
          });
          print("✅ Linked audio ID $audioIdStr to playlist ${newPlaylist.id}");
        } else {
          print("❌ Audio ID $audioIdStr does not exist in audio_files table. Skipping link.");
        }
      } catch (e) {
        print("❌ Error linking audio ID $audioId to playlist: $e");
      }
    }
  });

  return newPlaylist;
}



  @override
  Future<PlaylistModel> updatePlaylist(PlaylistModel playlist) async {
    final db = await dbInstance.database;
  await db.update(
    'playlists',
    playlist.toMap(),
    where: 'id = ?',
    whereArgs: [playlist.id],
  );
  return playlist;
  }

  @override
Future<void> deletePlaylist(String id) async {
  final db = await dbInstance.database;
  await db.delete(
    'playlists',
    where: 'id = ?',
    whereArgs: [id],
  );
  print("✅ Playlist with ID $id has been deleted.");
}
  
  @override
  Future<PlaylistModel> addAudioToPlaylist(String playlistId, String audioId) async {
    final db = await dbInstance.database;
    await db.insert('playlist_audio', {'playlist_id': playlistId, 'audio_id': audioId});
    return (await getPlaylistById(playlistId))!;
  }
  
  @override
  Future<PlaylistModel> removeAudioFromPlaylist(String playlistId, String audioId) async{
    
    final db = await dbInstance.database;
    await db.delete('playlist_audio', where: 'playlist_id = ? AND audio_id = ?', whereArgs: [playlistId, audioId]);
    return (await getPlaylistById(playlistId))!;
  }
}

class LocalUserDataSourceImpl implements LocalUserDataSource {
  final LocalDatabase dbInstance;

  LocalUserDataSourceImpl(this.dbInstance);

  @override
  Future<UserModel?> getCurrentUser() async {
    final db = await dbInstance.database;
    final result = await db.query('users');
    if (result.isEmpty) return null;
    return UserModel.fromMap(result.first);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final db = await dbInstance.database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteUser(String id) async {
    final db = await dbInstance.database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  

}