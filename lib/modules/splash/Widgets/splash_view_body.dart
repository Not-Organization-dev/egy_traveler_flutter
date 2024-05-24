import 'package:flutter/material.dart';

// import 'package:egytraveler/modules/splash/Widgets/animated_logo.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/assets.dart';
import '../../../shared/components/constants.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({
    super.key,
    required this.startWidget,
  });

  final Widget startWidget;

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeInAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    initSlidingANDFadeInAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //TODO: Get some SVGs that... acually.. work.

          // SvgPicture.asset(Assets.svgBusLogo),
          Image.asset(Assets.image4),
          const SizedBox(
            height: 20,
          ),
          // AnimatedLogo(
          //   fadeInAnimation: fadeInAnimation,
          //   slideAnimation: slideAnimation,
          // ),
          Image.asset(Assets.image6),
        ],
      ),
    );
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 4), () {
      navigateFish(context, widget.startWidget);
    });
  }

  void initSlidingANDFadeInAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade in animation
    fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    // Slide animation
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, .5),
      end: Offset.zero,
    ).animate(animationController);

    // Start the animation
    animationController.forward();
  }
}
