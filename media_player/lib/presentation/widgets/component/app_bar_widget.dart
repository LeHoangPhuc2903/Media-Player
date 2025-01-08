import 'package:flutter/material.dart';

class AppBarTile extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Text(
        'Trang chủ',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
