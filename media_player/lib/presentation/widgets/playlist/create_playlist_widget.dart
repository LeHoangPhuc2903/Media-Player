import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/home/home_modelview.dart';

class PlaylistCreationDialog extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  PlaylistCreationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Playlist Name Input
                  TextField(
                    onChanged: (value) => controller.newPlaylistName.value = value,
                    decoration: const InputDecoration(
                      labelText: "Playlist Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Select Audios or Show Placeholder
                  Text("Add Audios", style: const TextStyle(fontSize: 16)),
                  controller.audioFiles.isEmpty
                      ? const Center(child: Text("No audio files found."))
                      : SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.audioFiles.length,
                            itemBuilder: (context, index) {
                              final audio = controller.audioFiles[index];
                              final isSelected = controller.selectedAudios.contains(audio);

                              return GestureDetector(
                                onTap: () => controller.addAudioToSelectedList(audio),
                                child: Card(
                                  color: isSelected ? Colors.blueAccent : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        audio.hasImage
                                            ? Image.memory(audio.albumArt!, width: 50, height: 50, fit: BoxFit.cover)
                                            : const Icon(Icons.music_note, size: 50),
                                        Text(audio.title, style: const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                  // Selected Audios Preview
                  if (controller.selectedAudios.isNotEmpty)
                    SizedBox(
                      height: 128,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        children: controller.selectedAudios.map((audio) {
                          return Chip(
                            label: Text(audio.title),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => controller.removeAudioFromSelectedList(audio),
                          );
                        }).toList(),
                      ),
                    ),

                  const SizedBox(height: 10),

                  // Create/Cancel Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _confirmCancel(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () => _handleCreatePlaylist(context),
                        child: const Text("Create"),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _confirmCancel(BuildContext context) {
    if (controller.selectedAudios.isEmpty && controller.newPlaylistName.value.trim().isEmpty) {
      controller.newPlaylistName.value = '';
      controller.selectedAudios.clear();
      Navigator.of(context).pop();
      return;
    }

    Get.defaultDialog(
      title: "Cancel Creation?",
      middleText: "Are you sure you want to cancel? All selections will be lost.",
      textCancel: "No",
      textConfirm: "Yes",
      onConfirm: () {
        controller.newPlaylistName.value = '';
        controller.selectedAudios.clear();
        Navigator.of(context).pop();
        Get.back();
      },
    );
  }

  void _handleCreatePlaylist(BuildContext context) async {
  final name = controller.newPlaylistName.value.trim();

  if (name.isEmpty) {
    Get.snackbar("Error", "Playlist name cannot be empty!");
    return;
  }

  // Check for duplicate playlist names
  final exists = controller.playlists.any((p) => p.name == name);
  if (exists) {
    Get.snackbar("Error", "Playlist with this name already exists!");
    return;
  }

  final audioIds = controller.selectedAudios.map((audio) => audio.id).toList();
  print("Selected audio IDs: $audioIds");

  await controller.createNewPlaylistWithAudios();

  // Close dialog only after successful creation
  Navigator.of(context).pop();
}

}
