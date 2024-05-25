import 'package:egytraveler/Features/Auth/Presentation/view/reset_password_view.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/shared/components/constants.dart';
import 'package:flutter/material.dart';

class ResetPasswordTextButton extends StatelessWidget {
  const ResetPasswordTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResetPasswordView()));
          },
          child: Text(
            'Reset Password'.tr(context),
            style: TextStyle(
              color: const Color(0xFF3895A4),
              fontSize: getResponsiveFontSize(context, fontSize: 15),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
