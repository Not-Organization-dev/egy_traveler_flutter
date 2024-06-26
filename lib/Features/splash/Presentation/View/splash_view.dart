import 'package:flutter/material.dart';

import 'package:egytraveler/Features/splash/Presentation/View/Widgets/splash_view_body.dart';
import 'package:egytraveler/core/utils/color_manager.dart';

class SplashView extends StatelessWidget {
  final Widget startWidget;
  const SplashView({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.kColorPrimary,
        body: SafeArea(
          child: SplashViewBody(
            startWidget: startWidget,
          ),
        ));
  }
}
