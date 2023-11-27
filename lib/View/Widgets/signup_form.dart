import 'package:egy_taveler/View/Widgets/signup_terms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

import '../Components/circle_icon.dart';
import '../Components/wide_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

//TODO: use this function on buttons
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      //TODO: should replace this with something idk
      print("Valid Sign up Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 15, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 38.h,
            ),
            Text(
              "Let's Get Started!",
              style: GoogleFonts.roboto(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xff0b0b0b),
                height: (32 / 28).h,
              ),
            ),
            // const SizedBox(
            //   height: 8,
            // ),
            Text(
              "Sign up with Social of fill the form to continue.",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: (16 / 12).h,
                  ),
            ),
            SizedBox(
              height: 25.h,
            ),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  "assets/png_icons/mail.png",
                  width: 24.0,
                  height: 24.0,
                ),
                // prefixIcon: Icon(
                //   Icons.mail_outline,
                //   size: 24.sp,
                // ),
                hintText: "Email",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Name",
                  prefixIcon: Image.asset(
                    "assets/png_icons/user.png",
                    width: 24.0,
                    height: 24.0,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                ),
              ),
            ),

            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Image.asset(
                  "assets/png_icons/password.png",
                  width: 24.0,
                  height: 24.0,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              ),
            ),
            Text(
              "At least 8 charachers.",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: (16 / 12).h,
                  ),
            ),
            SizedBox(
              height: 39.h,
            ),

            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                SizedBox(
                  width: 270.w,
                  child: const SignUpTermsText(),
                ),
              ],
            ),
            SizedBox(
              height: 101.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 11.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleIcon(
                    icon: SvgPicture.asset(
                      "assets/svg_icons/logoTwitter.svg",
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  CircleIcon(
                    icon: SvgPicture.asset(
                      "assets/svg_icons/logoFacebook.svg",
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  CircleIcon(
                    icon: SvgPicture.asset(
                      "assets/svg_icons/devicon_google.svg",
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 42.h),
                child: WideButton(
                  buttonText: "Sign up",
                  textSize: 16,
                  buttonWidth: 129,
                  textColor: const Color.fromRGBO(255, 255, 255, 1),
                  buttonColor: const Color.fromRGBO(56, 149, 164, 1),
                  onTapButton: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
