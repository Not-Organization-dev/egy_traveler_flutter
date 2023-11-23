import 'package:egy_taveler/View/Screens/sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Global/Theme/theme.dart';

void main() {
  runApp(const EgyTraveler());
}

class EgyTraveler extends StatelessWidget {
  const EgyTraveler({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        theme: theme,
        home: const SignScreen(),
      ),
      designSize: const Size(360, 800),
    );
  }
}
