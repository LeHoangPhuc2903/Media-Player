import 'package:flutter/material.dart';

class MediaImageWidget extends StatelessWidget {
  final String imageUrl;

  const MediaImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
