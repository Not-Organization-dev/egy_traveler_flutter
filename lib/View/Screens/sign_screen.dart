import 'package:egy_taveler/View/Components/ui_small_top_buttons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({
    super.key,
    required this.showContent,
  });

  final Widget showContent;

  void backMethod(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //! final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 28,
                    height: 30.h,
                  ),
                  CustomUiSmallButton(
                    onTapAction: () {
                      backMethod(context);
                    },
                    icon: SvgPicture.asset("assets/svg_icons/chevronLeft.svg"),
                  ),
                ],
              ),
              showContent,
            ],
          ),
        ),
      ),
    );
  }
}
