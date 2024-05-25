import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:flutter/material.dart';

class SignInFormHeader extends StatelessWidget {
  const SignInFormHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome'.tr(context),
          style: Styles.textBold20,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          'Sign up with Social of fill the form to continue.'.tr(context),
          style: Styles.textThin10,
        ),
      ],
    );
  }
}
