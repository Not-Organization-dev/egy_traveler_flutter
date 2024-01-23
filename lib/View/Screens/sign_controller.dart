import 'package:egy_taveler/View/Components/wide_button.dart';
import 'package:egy_taveler/View/Screens/sign_screen.dart';
import 'package:egy_taveler/View/Widgets/signin_form.dart';
import 'package:egy_taveler/View/Widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignScreenController extends StatelessWidget {
  const SignScreenController({super.key});

  void backMethod(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //! final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/signController_screen.png",
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 113.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 47.w),
              child: Text(
                "EgyTraveler",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 44.sp,
                  fontWeight: FontWeight.w900,
                  height: (52 / 44).h,
                ),
              ),
            ),
            SizedBox(
              height: 402.h,
            ),
            WideButton(
              buttonText: "Sign up",
              textSize: 22,
              buttonWidth: 328,
              textColor: const Color(0xff2b3437),
              buttonColor: Colors.white,
              onTapButton: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignScreen(
                      showContent: SignUpForm(),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 27.h),
              child: WideButton(
                buttonText: "Sign in",
                textSize: 22,
                buttonWidth: 328,
                textColor: Colors.white,
                buttonColor: Colors.black.withOpacity(.6),
                onTapButton: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignScreen(
                        showContent: SignInForm(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
