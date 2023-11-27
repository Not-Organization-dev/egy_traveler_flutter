import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:egy_taveler/View/Components/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Components/ui_small_top_buttons.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  void backMethod(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomUiSmallButton(
                    onTapAction: () {
                      backMethod(context);
                    },
                    icon: SvgPicture.asset("assets/svg_icons/chevronLeft.svg"),
                  ),
                ],
              ),
              SizedBox(
                height: 72.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone Verification",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400,
                        height: (32 / 28).h,
                      ),
                    ),
                    Text(
                      "Please enter the 4-digit code send to you at\nPHONE PLACEHOLDER.",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontSize: 12.sp,
                          ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Resend Code",
                        style: GoogleFonts.roboto(
                          color: const Color.fromRGBO(18, 18, 29, 0.6),
                        ),
                      ),
                    ),
                    SizedBox(height: 21.h),
                    Center(
                      child: PinCodeTextField(
                        appContext: context,
                        length: 5, // Change the length as needed
                        onChanged: (value) {
                          // Handle OTP input
                          print(value);
                        },
                        cursorColor: Colors.black,
                        cursorWidth: 1,

                        keyboardType: TextInputType.number,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.circle,
                          borderRadius: BorderRadius.circular(5.r),
                          fieldHeight: 56.h,
                          fieldWidth: 56.w,
                          activeFillColor: Colors.white,
                          inactiveColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 72.h,
              ),
              Center(
                child: WideButton(
                  buttonText: "Next",
                  textSize: 16,
                  textColor: Colors.white,
                  buttonColor: const Color.fromRGBO(56, 149, 164, 1),
                  onTapButton: () {},
                  buttonWidth: 156,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
