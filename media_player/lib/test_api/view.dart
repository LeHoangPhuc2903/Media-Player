import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model_view.dart';


class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlaylistViewModel viewModel = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text('Playlists')),
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (viewModel.hasError.value) {
          return Center(child: Text('Error: ${viewModel.errorMessage.value}'));
        } else {
          return ListView.builder(
            itemCount: viewModel.playlists.length,
            itemBuilder: (context, index) {
              final playlist = viewModel.playlists[index];
              return ListTile(
                title: Text(playlist.name),
              );
            },
          );
        }
      }),
    );
  }
}