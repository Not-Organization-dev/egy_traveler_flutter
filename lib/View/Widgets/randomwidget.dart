import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xff0b0b0b),
                height: (33 / 32).h,
              ),
          // style: TextStyle(
          //   fontFamily: "Roboto",
          //   fontSize: 32.sp,
          //   fontWeight: FontWeight.w700,
          //   color: const Color(0xff0b0b0b),
          //   height: (33 / 32).h,
          // ),
          textAlign: TextAlign.left,
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
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                height: (22 / 18).h,
              ),
        ),
        TextFormField(),
      ],
    );
  }
}
