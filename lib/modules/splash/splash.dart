import 'package:egytraveler/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../shared/components/constants.dart';

class SplashScreen extends StatefulWidget {
  final Widget startWidget;
  const SplashScreen({super.key, required this.startWidget});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
/*  late AnimationController animationController ;
  late Animation<Offset> animation ;

  late AnimationController animationController1 ;
  late Animation<Offset> animation1 ;*/

  @override
  void initState() {
    super.initState();
    // initSlidingAnimation();
    // initSlidingAnimation1();
    navigateToHome();
  }

/*  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    animationController1.dispose();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.kColorPrimary,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(Assets.image4),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(Assets.image6),
              ],
            ),
          ),
        ));
  }

/*  void initSlidingAnimation(){
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 1800));
    animation = Tween<Offset>(
      begin: const Offset(-2, 0),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }

  void initSlidingAnimation1() {
    animationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    animation1 = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(animationController1);
    animationController1.forward();
  }*/

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 4), () {
      navigateFish(context, widget.startWidget);
    });
  }
}
