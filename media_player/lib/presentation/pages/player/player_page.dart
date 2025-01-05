import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  final Map<String, String> songData;

  PlayerPage({required this.songData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đang phát: ${songData['playlistTitle']}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hiển thị hình playlist hoặc bài hát
          Image.asset(
            songData['playlistImage']!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          // Hiển thị tên bài hát
          Text(
            songData['title']!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // Hiển thị nghệ sĩ hoặc thông tin bổ sung
          Text(
            songData['subtitle']!,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 16),
          // Thanh tiến trình phát nhạc (giả lập)
          Slider(
            value: 0.5,
            onChanged: (value) {
              // Xử lý khi kéo thanh tiến trình
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1:33'),
              Text('3:40'),
            ],
          ),
          SizedBox(height: 16),
          // Các nút điều khiển phát nhạc
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, size: 36),
                onPressed: () {
                  // Xử lý quay lại bài hát trước
                },
              ),
              IconButton(
                icon: Icon(Icons.play_arrow, size: 36),
                onPressed: () {
                  // Xử lý phát nhạc
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, size: 36),
                onPressed: () {
                  // Xử lý chuyển bài hát
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
