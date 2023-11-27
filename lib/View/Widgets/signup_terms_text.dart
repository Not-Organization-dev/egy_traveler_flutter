import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpTermsText extends StatelessWidget {
  const SignUpTermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      softWrap: true,
      text: TextSpan(
        text: 'By Signing up, you agree to the ',
        style: GoogleFonts.roboto(
          color: Colors.black.withOpacity(.5),
        ),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            // Add a tap gesture recognizer for the "Terms of Service" link
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle the tap on "Terms of Service" link
                print('Terms of Service tapped!');
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),

            // Add a tap gesture recognizer for the "Privacy Policy" link
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle the tap on "Privacy Policy" link
                print('Privacy Policy tapped!');
              },
          ),
        ],
      ),
    );
  }
}
