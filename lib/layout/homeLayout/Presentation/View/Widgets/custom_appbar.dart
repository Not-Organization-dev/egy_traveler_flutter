import 'package:flutter/material.dart';
import 'package:egytraveler/generated/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        Assets.image6,
        width: 100,
        height: 100,
      ),
      centerTitle: true,
      backgroundColor: const Color(0x66D9D9D9),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
