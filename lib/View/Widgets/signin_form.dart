import 'package:egy_taveler/View/Components/circle_icon.dart';
import 'package:egy_taveler/View/Components/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("Valid Sign in Data");
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
              height: 67.h,
            ),
            Text(
              "Welcome",
              style: GoogleFonts.roboto(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: const Color.fromRGBO(18, 18, 29, 1),
                height: (32 / 28).h,
              ),
            ),
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
              height: 77.h,
            ),
            const Divider(indent: 3, endIndent: 6),
            SizedBox(
              height: 28.5.h,
            ),
            TextFormField(
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
            SizedBox(
              height: 10.h,
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
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          height: (15 / 12).h,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Text(
                  "Remamber me next time",
                  style: GoogleFonts.roboto(
                    color: Colors.black.withOpacity(.6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: (16 / 12),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 58.h,
            ),
            Row(
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
            SizedBox(
              height: 40.h,
            ),
            Center(
              child: WideButton(
                buttonText: "Sign in",
                textSize: 16,
                buttonWidth: 129,
                textColor: const Color.fromRGBO(255, 255, 255, 1),
                buttonColor: const Color.fromRGBO(56, 149, 164, 1),
                onTapButton: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
