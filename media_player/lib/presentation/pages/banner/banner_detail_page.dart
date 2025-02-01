import 'package:flutter/material.dart';

class BannerDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const BannerDetailPage({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl),
            SizedBox(height: 20),
            Text(title, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}