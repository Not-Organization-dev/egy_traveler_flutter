import 'dart:async';

import 'package:flutter/material.dart';

import 'package:egytraveler/Features/onBoarding/Presentation/Manager/boarding_model.dart';
import 'package:egytraveler/Features/onBoarding/Presentation/view/widget/on_boarding_skip_button.dart';
import 'package:egytraveler/Features/onBoarding/Presentation/view/widget/on_boarding_smooth_page_indicator.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/shared/components/constants.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  // Variable to track if the current page is the last one
  bool isLast = true;
  // Controller for managing the page view
  final PageController controller = PageController(initialPage: 0);
  // Index of the current page
  int currentIndex = 0;
  // Timer for auto-play functionality
  Timer? timer;
  // List of onboarding screen models
  List<BoardingModel> boarding = [
    BoardingModel(
      image: Assets.imageOnboarding1,
      title: 'titleOnBoarding1',
      body: "bodyOnBoarding1",
    ),
    BoardingModel(
      image: Assets.imageOnboarding2,
      title: 'titleOnBoarding2',
      body: "bodyOnBoarding2",
    ),
    BoardingModel(
      image: Assets.imageOnboarding3,
      title: 'titleOnBoarding3',
      body: "bodyOnBoarding3",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Start auto-play when the widget is initialized
    _startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Widget for displaying onboarding pages
          _onBoardingPages(),
          // Widget for displaying skip button
          Positioned(
            top: 50,
            right: 20,
            child: OnBoardingSkipButton(isLast: isLast),
          ),
          // Widget for displaying page indicator dots
          Positioned(
            bottom: 250,
            left: 20,
            child: OnBoardingSmoothPageIndicator(controller: controller),
          ),
          // Widget for displaying title text
          Positioned(
            bottom: 210,
            left: 20,
            child: Text(
              boarding[currentIndex].title.tr(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 22),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          // Widget for displaying body text
          Positioned(
            bottom: 150,
            left: 20,
            child: SizedBox(
              width: 210,
              child: Text(
                textAlign: TextAlign.start,
                boarding[currentIndex].body.tr(context),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getResponsiveFontSize(context, fontSize: 16),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for building the page view of onboarding screens
  PageView _onBoardingPages() {
    return PageView.builder(
      controller: controller,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(boarding[index].image),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      itemCount: boarding.length,
      onPageChanged: _onPageChanged,
    );
  }

  // Method to start auto-play functionality
  void _startAutoPlay() {
    const autoPlayDuration = Duration(seconds: 3);
    timer = Timer.periodic(autoPlayDuration, (timer) {
      if (currentIndex < 2) {
        controller.nextPage(
            duration: const Duration(milliseconds: 1000), curve: Curves.ease);
      } else {
        // Stop the timer when reaching the last screen
        timer.cancel();
      }
    });
  }

  // Method called when page is changed
  void _onPageChanged(int page) {
    setState(() {
      currentIndex = page;
      // Update isLast based on whether the current page is the last one
      if (page == boarding.length - 1) {
        isLast = true;
      } else {
        isLast = false;
      }
    });
  }
}
