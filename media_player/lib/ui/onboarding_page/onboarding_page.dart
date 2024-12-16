import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Image in the top half of the screen
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboard_image.png'), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Centered Text
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Âm nhạc dựa trên tâm hồn của bạn",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Đăng nhập để lưu tiến trình hoặc không",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                
                // Facebook Sign Up Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Xử lý đăng nhập facebook
                  },
                  icon: Icon(FontAwesomeIcons.facebook),
                  label: Text("Tiếp tục với Facebook"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 15),

                // Google Sign Up Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Xử lý đăng nhập gg
                  },
                  icon: Icon(FontAwesomeIcons.google),
                  label: Text("Tiếp tục với Google"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    // Xử lý không tài khoản
                  },
                  icon: Icon(FontAwesomeIcons.google),
                  label: Text("Tiếp tục không cần đăng nhập"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 20),

                // DKDV và CSBM hiển thị khi nhấn vào
                Text(
                  "Bằng cách tiếp tục, bạn đồng ý Điều khoản dịch vụ và Chính sách bảo mật của chúng tôi.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
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
