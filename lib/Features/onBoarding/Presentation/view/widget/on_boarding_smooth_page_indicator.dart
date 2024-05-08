import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingSmoothPageIndicator extends StatelessWidget {
  const OnBoardingSmoothPageIndicator({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      onDotClicked: (index) => controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
      effect: ExpandingDotsEffect(
        expansionFactor: 3,
        spacing: 8.0,
        radius: 5,
        dotWidth: 10.0,
        dotHeight: 10.0,
        paintStyle: PaintingStyle.fill,
        strokeWidth: .1,
        dotColor: ColorManager.kDotColorActive,
        activeDotColor: ColorManager.kColorIdle,
      ),
    );
  }
}
