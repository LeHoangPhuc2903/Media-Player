import 'dart:io';
import 'dart:typed_data';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_player/presentation/widgets/component/square_slider_thumb.dart';




class PlayerPage extends StatefulWidget {
  final String audioUrl;

  PlayerPage({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  
  String _title = "Unknown Title";
  String _artist = "Unknown Artist";
  String _album = "Unknown Album";
  Uint8List? _albumArt;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
    
    
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          _totalDuration = duration;
        });
      }
    });
  }

  Future<void> _initAudio() async {
  try {
    print("🎵 Trying to load: ${widget.audioUrl}");

    File audioFile = File(widget.audioUrl);
    if (!audioFile.existsSync()) {
      print("❌ File does not exist: ${widget.audioUrl}");
      return;
    }

    await _audioPlayer.setFilePath(widget.audioUrl);
    setState(() {
      _totalDuration = _audioPlayer.duration ?? Duration.zero;
    });
    final metadata = readMetadata(audioFile);
      setState(() {
        _title = metadata.title ?? audioFile.uri.pathSegments.last.replaceAll('.mp3', '');
        _artist = metadata.artist ?? "Unknown Artist";
        _album = metadata.album ?? "Unknown Album";
        
      });
    print("✅ Metadata Loaded: $_title - $_artist");
    print("✅ Audio loaded successfully!");
  } catch (e) {
    print("❌ Error loading audio: $e");
  }
}


  void _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seekTo(double seconds) {
    _audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  void _stop() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _currentPosition = Duration.zero;
    });
  }

  void _rewind() {
    if (_currentPosition.inSeconds > 10) {
      _audioPlayer.seek(_currentPosition - Duration(seconds: 10));
    }else{
      _audioPlayer.seek(Duration.zero);
    }   
  }

  void _forward() {
    if (_currentPosition + Duration(seconds: 10) < _totalDuration) {
      _audioPlayer.seek(_currentPosition + Duration(seconds: 10));
    }else{
      _audioPlayer.seek(_totalDuration);
    }
  }

  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
void dispose() {
  _audioPlayer.stop();
  _audioPlayer.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _albumArt != null
                ? Image.memory(_albumArt!, width: 150, height: 150, fit: BoxFit.cover)
                : Icon(Icons.music_note, size: 150, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              _title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              _artist,
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            Text(
              _album,
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            SliderTheme(
              data: SliderThemeData(
                
                thumbShape: SquareSliderThumbShape(thumbSize: 12),                
                trackHeight: 2.5,
                trackShape: RectangularSliderTrackShape(),
                activeTrackColor: Colors.blueAccent,
                inactiveTrackColor: Colors.grey.shade300,
                thumbColor: Colors.blue,
                overlayColor: Colors.blue.withOpacity(0.2),
              ),
              child: Slider(
                value: _currentPosition.inSeconds.toDouble(),
                max: _totalDuration.inSeconds > 0 ? _totalDuration.inSeconds.toDouble() : 1.0,
                onChanged: (value) {
                  setState(() {
                    _currentPosition = Duration(seconds: value.toInt());
                  }); 
                },
                onChangeEnd: (value) {
                    _seekTo(value);
                }   
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(_currentPosition)),
                  Text(_formatDuration(_totalDuration)),
                ],
              ),
            ),

            SizedBox(height: 20),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.replay_10, size: 36),
                  onPressed: _rewind,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: _isPlaying
                    ? Icon(Icons.pause_circle_filled, size: 50, color: Colors.blue) : (_totalDuration == Duration.zero
                      ? CircularProgressIndicator() : Icon(Icons.play_circle_filled, size: 50, color: Colors.blue)),
                  onPressed: _playPause,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.forward_10, size: 36),
                  onPressed: _forward,
                ),
              ],
            ),

            SizedBox(height: 20),

            
            ElevatedButton(
              onPressed: _stop,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text("Stop", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}


