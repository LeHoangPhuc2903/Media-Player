import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/widgets/component/bottom_nav_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/data/assets/images/user.jpg'),
            ),
            SizedBox(height: 20),
            Text('User Name', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('user@example.com', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: 2, // Index của tab "Profile"
        onTabSelected: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed(Routes.home); // Điều hướng về HomePage
              break;
            case 1:
              Get.offAllNamed(Routes.search); // Điều hướng về SearchPage
              break;
            case 2:
              break; // Tab hiện tại, không cần điều hướng
          }
        },
      ),
    );
  }
}
