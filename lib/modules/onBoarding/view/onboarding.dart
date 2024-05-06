import 'dart:async';

import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/modules/onBoarding/view/signInAndUp.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../core/resources/color_manager.dart';

class BoardingModel {
  String title;
  String image;
  String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isLast = true;
  var controller = PageController();
  int currentIndex = 0;
  late Timer timer;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
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
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
              if (index == boarding.length - 1) {
                setState(() {
                  isLast = true;
                });
              } else {
                setState(() {
                  isLast = false;
                });
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 40, bottom: 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        CacheHelper.saveData(key: 'onBoarding', value: true)
                            .then((value) {
                          if (value == true) {
                            navigateFish(context, const SignInAndUp());
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            isLast ? 'Start'.tr(context) : 'skip'.tr(context),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  getResponsiveFontSize(context, fontSize: 22),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      effect: ExpandingDotsEffect(
                        expansionFactor: 5,
                        spacing: 8.0,
                        radius: 5,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: .1,
                        dotColor: ColorManager.kDotColorActive,
                        activeDotColor: ColorManager.kColorIdle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  boarding[currentIndex].title.tr(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getResponsiveFontSize(context, fontSize: 22),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  boarding[currentIndex].body.tr(context),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getResponsiveFontSize(context, fontSize: 16),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
class _OnBoardingState extends State<OnBoarding> {

  bool isLast = true ;
  var controller = PageController() ;
  late Timer timer;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: Assets.imageOnboarding1,
      title:'titleOnBoarding1',
      body:"bodyOnBoarding1" ,
    ),

    BoardingModel(
      image: Assets.imageOnboarding2,
      title:'titleOnBoarding2',
      body:"bodyOnBoarding2" ,
    ),

    BoardingModel(
      image: Assets.imageOnboarding3,
      title:'titleOnBoarding3',
      body:"bodyOnBoarding3" ,
    ),
  ];

  @override
  void initState() {
    super.initState();
*/
/*
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (isLast) {
        controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
*//*

  }

  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks
    timer.cancel();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemBuilder:  (context , index) {
                return onBoardingScreen(boarding[index], isLast);
              },
              itemCount:boarding.length,
              onPageChanged: (index){
                if(index == boarding.length-1){
                  setState(() {
                    isLast = true ;
                  });
                }else{
                  setState(() {
                    isLast = false ;
                  });
                }
              },
            ),
          ),
        ],
      ) ,
    );
  }


  Widget onBoardingScreen( BoardingModel model, bool isLast) => Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(model.image),
          fit: BoxFit.cover
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16,top: 40,bottom: 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: (){
                  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
                    if(value == true){
                      navigateFish(context, const SignInAndUp());
                    }
                  });
                },
                child: Row(
                  children: [
                    Text(
                      isLast ?   'Start'.tr(context) : 'skip'.tr(context),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getResponsiveFontSize(context,fontSize: 22),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
                effect: ExpandingDotsEffect(
                  expansionFactor: 5,
                  spacing:  8.0,
                  radius:  5,
                  dotWidth:  10.0,
                  dotHeight:  10.0,
                  paintStyle:  PaintingStyle.fill,
                  strokeWidth: .1,
                  dotColor:  ColorManager.dotColorActive,
                  activeDotColor: ColorManager.dotColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.title.tr(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context,fontSize: 22),
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            model.body.tr(context),
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context,fontSize: 16),
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    ),
  );
}*/
