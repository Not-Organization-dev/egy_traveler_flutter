import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    super.key,
    required this.buttonText,
    required this.textSize,
    required this.textColor,
    required this.buttonColor,
    required this.onTapButton,
    required this.buttonWidth,
  });

  final String buttonText;
  final int textSize;
  final Color textColor;
  final Color buttonColor;
  final int buttonWidth;

  final void Function() onTapButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(
          30.r,
        ),
      ),
      onTap: onTapButton,
      child: Container(
        width: buttonWidth.w,
        height: 55.h,
        decoration: ShapeDecoration(
          // color: const Color.fromRGBO(43, 52, 55, 1),
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.roboto(
              fontSize: textSize.sp,
              fontWeight: FontWeight.w700,
              // color: const Color.fromRGBO(255, 255, 255, 1),
              color: textColor,
              height: (27 / 22).h,
            ),
          ),
        ),
      ),
    );
  }
}
