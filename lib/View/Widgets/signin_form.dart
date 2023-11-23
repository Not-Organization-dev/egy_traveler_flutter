import 'package:egy_taveler/View/Components/circle_icon.dart';
import 'package:egy_taveler/View/Components/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign in",
            style: GoogleFonts.roboto(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff0b0b0b),
              height: (33 / 32).h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              "Sign in to use the app.",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    height: (18 / 15).h,
                  ),
            ),
          ),
          SizedBox(
            height: 18.h,
          ),
          Text(
            "Email",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 18.sp,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                  height: (22 / 18).h,
                ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.h),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              ),
            ),
          ),
          SizedBox(
            height: 13.h,
          ),
          Text(
            "Password",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 18.sp,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                  height: (22 / 18).h,
                ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.h),
            child: TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot password?",
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
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 17.h),
              child: WideButton(
                buttonText: "Sign in",
                textColor: const Color.fromRGBO(255, 255, 255, 1),
                buttonColor: const Color.fromRGBO(43, 52, 55, 1),
                onTapButton: () {},
              ),
            ),
          ),
          SizedBox(
            height: 40.h, // Adjust the height as needed
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.06),
                    height: 1.0.h,
                  ),
                ),
                Text(
                  'Or login with',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff000000),
                        height: (13 / 11).h,
                      ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.06),
                    height: 1.0.h,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 11.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleIcon(
                  icon: FaIcon(
                    size: 28.sp,
                    FontAwesomeIcons.twitter,
                  ),
                ),
                CircleIcon(
                  icon: FaIcon(
                    size: 28.sp,
                    FontAwesomeIcons.facebook,
                  ),
                ),
                CircleIcon(
                  icon: FaIcon(
                    size: 28.sp,
                    FontAwesomeIcons.google,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t have any account?",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Sign up",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
