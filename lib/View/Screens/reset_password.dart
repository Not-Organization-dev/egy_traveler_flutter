import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:egy_taveler/View/Components/wide_button.dart';
import 'package:egy_taveler/View/Screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/ui_small_top_buttons.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
                      "Forgot your password?",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        height: (32 / 26).h,
                      ),
                    ),
                    Text(
                      "If you need help resetting your password\nwe can help by sending you a link to reset it.",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontSize: 12.sp,
                          ),
                    ),
                    SizedBox(height: 71.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Row(
                        children: [
                          // Country Picker
                          CountryPickerDropdown(
                            icon:
                                SvgPicture.asset("assets/svg_icons/Vector.svg"),
                            initialValue: 'EG',
                            itemBuilder: (Country country) {
                              return Row(
                                children: [
                                  CountryPickerUtils.getDefaultFlagImage(
                                      country),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "+${country.phoneCode}",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ],
                              );
                            },
                            onValuePicked: (Country country) {
                              print(country.name);
                            },
                          ),
                          // Spacer between Country Picker and TextField
                          SizedBox(width: 16.w),
                          // Text Field
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Phone Number',
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
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
                  onTapButton: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const OTPScreen(),
                      ),
                    );
                  },
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
