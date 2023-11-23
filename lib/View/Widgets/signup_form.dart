import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("Valid Sign up Data");
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
            "Sign Up",
            style: GoogleFonts.roboto(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff0b0b0b),
              height: (33 / 32).h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              "Enter your personal information.",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    height: (18 / 15).h,
                  ),
            ),
          ),
          Text(
            "Username",
            // style: TextStyle(
            //   fontFamily: "Inter",
            //   fontSize: 18.sp,
            //   fontWeight: FontWeight.w700,
            //   color: Color(0xff000000),
            //   height: (22 / 18).h,
            // ),
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
              controller: _emailController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              ),
            ),
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
          Text(
            "Confirm password",
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
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 36.h),
              child: WideButton(
                buttonText: "Sign up",
                textColor: const Color.fromRGBO(255, 255, 255, 1),
                buttonColor: const Color.fromRGBO(43, 52, 55, 1),
                onTapButton: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
