import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_player/presentation/widgets/player/media_image_widget.dart';
import 'package:media_player/presentation/widgets/player/media_info_widget.dart';
import 'package:media_player/presentation/widgets/player/playback_controls_widget.dart';
import 'package:media_player/presentation/widgets/player/progress_bar_widget.dart';


class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Now Playing")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MediaImageWidget(
              imageUrl: "https://via.placeholder.com/200",
            ),
            const SizedBox(height: 20),
            const MediaInfoWidget(
              title: "Song Title",
              artist: "Artist Name",
            ),
            const SizedBox(height: 20),
            ProgressBarWidget(
              currentPosition: _currentPosition,
              totalDuration: _totalDuration,
              onSeek: (value) {
                _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            const SizedBox(height: 20),
            PlaybackControlsWidget(
              isPlaying: _isPlaying,
              onPlay: () {
                _audioPlayer.play();
              },
              onPause: () {
                _audioPlayer.pause();
              },
              onNext: () {
                print("Next song");
              },
              onPrevious: () {
                print("Previous song");
              },
            ),
          ],
        ),
      ),
    );
  }
}
