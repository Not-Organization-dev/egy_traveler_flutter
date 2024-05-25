import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/utils/styles.dart';

class SignUpFormHeader extends StatelessWidget {
  const SignUpFormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let’s Get Started!'.tr(context),
          style: Styles.textBold20,
        ),
        const SizedBox(height: 3),
        Text(
          'Sign up with Social'.tr(context),
          style: Styles.textRegular12.copyWith(
            color: ColorManager.kColorIdle,
          ),
        ),
      ],
    );
  }
}
