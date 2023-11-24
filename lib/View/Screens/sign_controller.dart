import 'package:egy_taveler/View/Components/wide_button.dart';
import 'package:egy_taveler/View/Screens/sign_screen.dart';
import 'package:egy_taveler/View/Widgets/signin_form.dart';
import 'package:egy_taveler/View/Widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/ui_small_top_buttons.dart';

class SignScreenController extends StatelessWidget {
  const SignScreenController({super.key});

  void backMethod(BuildContext context) {
    Navigator.pop(context);
  }

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
                    CustomUiSmallButton(
                      onTapAction: () {
                        backMethod(context);
                      },
                      icon: SvgPicture.asset("assets/svg_icons/back.svg"),
                    ),
                    const Spacer(),
                    CustomUiSmallButton(
                      onTapAction: () {},
                      icon: SvgPicture.asset("assets/svg_icons/close.svg"),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/svg_icons/MobileLoginAmico.svg",
                    width: 394.w,
                    height: 368.h,
                  ),
                ),
                Text(
                  "Welcome to EgyTraveler",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 24.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        height: (33 / 24).h,
                      ),
                ),
                Text(
                  "EgyTraveler: Your Smart Travel Guide.",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.h),
                  child: WideButton(
                    buttonText: "Sign in",
                    textColor: Colors.white,
                    buttonColor: const Color.fromRGBO(43, 52, 55, 1),
                    borderColor: const Color.fromRGBO(43, 52, 55, 1),
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
                WideButton(
                  buttonText: "Sign up",
                  textColor: const Color(0xff2b3437),
                  buttonColor: Colors.white,
                  borderColor: const Color(0xff2b3437),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
