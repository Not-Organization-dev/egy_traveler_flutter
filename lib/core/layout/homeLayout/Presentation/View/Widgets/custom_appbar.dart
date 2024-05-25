import 'package:egytraveler/core/utils/color_manager.dart';
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
      backgroundColor: ColorManager.kCustomAppBarColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
