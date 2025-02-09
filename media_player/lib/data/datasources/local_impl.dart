import 'package:media_player/domain/entities/playlist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:media_player/data/models/audio_file_model.dart';
import 'package:media_player/data/models/playlist_model.dart';
import 'package:media_player/data/models/user_model.dart';
import 'package:media_player/data/datasources/local.dart';

class LocalDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'media_player.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE audio_files (
            id TEXT PRIMARY KEY,
            title TEXT,
            artist TEXT,
            duration INTEGER,
            filePath TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE playlists (
            id TEXT PRIMARY KEY,
            name TEXT,
            audioIds TEXT
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
      await db.insert('audio_files', file.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}

class LocalPlaylistDataSourceImpl implements LocalPlaylistDataSource {
  final LocalDatabase dbInstance;

  LocalPlaylistDataSourceImpl(this.dbInstance);

  @override
  Future<List<PlaylistModel>> getAllPlaylists() async {
    final db = await dbInstance.database;
    final result = await db.query('playlists');
    return result.map((e) => PlaylistModel.fromMap(e)).toList();
  }

  @override
  Future<PlaylistModel?> getPlaylistById(String id) async {
    final db = await dbInstance.database;
    final result = await db.query('playlists', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return PlaylistModel.fromMap(result.first);
  }

  @override
  Future<PlaylistModel> createNewPlaylist(String name) async {
    final db = await dbInstance.database;
    final newPlaylist = PlaylistModel(id: DateTime.now().toString(), name: name, audioIds: []);
    await db.insert('playlists', newPlaylist.toMap());
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
    await db.delete('playlists', where: 'id = ?', whereArgs: [id]);
  }
  
  @override
  Future<PlaylistModel> addAudioToPlaylist(String playlistId, String audioId) {
    // TODO: implement addAudioToPlaylist
    throw UnimplementedError();
  }
  
  @override
  Future<PlaylistModel> removeAudioFromPlaylist(String playlistId, String audioId) {
    // TODO: implement removeAudioFromPlaylist
    throw UnimplementedError();
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