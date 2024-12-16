import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed('/onboard');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          
          Center(
            child: Icon(
              Icons.music_note, // Replace with your icon
              size: 100, // Icon size
              color: Colors.blueAccent, // Icon color
            ),
          ),
          // Text at the bottom
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Âm nhạc là liều thuốc trái tim",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "Âm nhạc là món ăn tinh thần",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "Âm nhạc là nơi kết nối tâm hồn",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
