import 'package:flutter/material.dart';

import 'package:egytraveler/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/sign_in_and_up_view.dart';
import 'package:egytraveler/shared/components/size_config.dart';
import 'package:egytraveler/shared/network/local/cache_helper.dart';

void singOut(context) {
  CacheHelper.clearData(key: 'ID').then((value) {
    CacheHelper.clearData(key: 'isRemember');
    CacheHelper.clearData(key: 'TokenId');
    if (value == true) {
      HomeCubit.get(context).userData = null;
      navigateFish(context,
          const SignInAndUpView()); // add Login Screen here because singOut and login again
      debugPrint("token inside clear data : $token uid : $uid");
    }
  });
  if (token != null || uid != null) {
    token = null;
    uid = null;
    isRemember = false;
    debugPrint("token in side if condition: $token uid : $uid");
  }
  debugPrint('token : $token');
  debugPrint('uid: $uid');
}

void navigateFish(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
    (route) => false,
  );
}

String? token = CacheHelper.getData(key: 'TokenId');

String? uid = CacheHelper.getData(key: 'ID');

String? themeModeCacheHelper = CacheHelper.getData(key: 'theme');

bool? isRemember = CacheHelper.getData(key: 'isRemember');

bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

bool? language = CacheHelper.getData(key: 'SettingsPage');

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < SizeConfig.tablet) {
    return width / 550;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1600;
  }
}
