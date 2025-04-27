import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/domain/entities/playlist.dart';
import 'package:media_player/presentation/pages/home/home_modelview.dart';
import 'package:media_player/presentation/pages/player/player_page.dart';

class PlaylistPage extends StatefulWidget {
  final Playlist playlist;

  PlaylistPage({super.key, required this.playlist});

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final HomeController homeController = Get.find<HomeController>();

  Rx<Playlist?> currentPlaylist = Rx<Playlist?>(null);

  @override
  void initState() {
    super.initState();
    _loadPlaylistDetails();
  }

  
  Future<void> _loadPlaylistDetails() async {
  final updatedPlaylist = await homeController.getPlaylistByIdWithAudios(widget.playlist.id);
  currentPlaylist.value = updatedPlaylist ?? widget.playlist;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(currentPlaylist.value?.name ?? "Playlist")),
        actions: [
          IconButton(
            onPressed: () => _confirmDelete(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Obx(() {
        if (currentPlaylist.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (currentPlaylist.value!.audioFiles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.music_off, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text("No audios in this playlist"),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: currentPlaylist.value!.audioFiles.length,
          itemBuilder: (context, index) {
            final audio = currentPlaylist.value!.audioFiles[index];
            return ListTile(
              title: Text(audio.title),
              subtitle: Text(audio.artist),
              leading: const Icon(Icons.music_note),
              trailing: const Icon(Icons.play_arrow),
              onTap: () {
                Get.to(() => PlayerPage(), arguments: audio);
              },
            );
          },
        );
      }),
    );
  }

  void _confirmDelete(BuildContext context) {
  final playlistName = widget.playlist.name;

  Get.dialog(
    AlertDialog(
      title: const Text("Delete Playlist?"),
      content: Text("Are you sure you want to delete '$playlistName'?"),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () async {
           
            await homeController.deleteExistingPlaylist(widget.playlist.id);
            await homeController.scanAndLoadData();
            Get.back(closeOverlays: true);
            Get.snackbar("Deleted", "Playlist '$playlistName' has been deleted!");
          },
          child: const Text("Yes"),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

}
