import 'package:flutter/material.dart';

import 'package:egytraveler/generated/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
    required this.fadeInAnimation,
    required this.slideAnimation,
  });

  final Animation<double> fadeInAnimation;
  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    //TODO: SVGs here too
    return AnimatedBuilder(
      animation: fadeInAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeInAnimation,
            // child: Image.asset(Assets.image6),

            child: SvgPicture.asset(Assets.svgTextLogo),
          ),
        );
      },
    );
  }
}
