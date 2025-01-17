import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/view_models/playlist_view_model.dart';

class PlaylistPage extends StatelessWidget {
  final PlaylistViewModel viewModel;

  PlaylistPage(this.viewModel, {required String title, required String image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Playlists')),
      body: Obx(() {
        if (viewModel.playlists.isEmpty) {
          return Center(child: Text('No playlists found.'));
        }
        return ListView.builder(
          itemCount: viewModel.playlists.length,
          itemBuilder: (context, index) {
            final playlist = viewModel.playlists[index];
            return ListTile(
              title: Text(playlist.name),
              onTap: () {
                // Navigate to track list
              },
            );
          },
        );
      }),
    );
  }
}
