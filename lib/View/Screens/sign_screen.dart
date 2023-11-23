import 'package:egy_taveler/View/Widgets/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/signup_form.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //! final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38.w,
                      height: 36.h,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 38.w,
                      height: 36.h,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/egyTravelerLogo.png',
                        width: 109.w,
                        height: 111.h,
                      ),
                    ],
                  ),
                ),
                const SignInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
