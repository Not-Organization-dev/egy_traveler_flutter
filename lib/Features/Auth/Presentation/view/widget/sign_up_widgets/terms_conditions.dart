import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:egytraveler/core/utils/styles.dart';

class TermsConditions extends StatelessWidget {
  final bool isActive;
  final bool checkbox;
  final VoidCallback onTap;

  const TermsConditions({
    required this.isActive,
    required this.checkbox,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        checkbox
            ? const Text(
                '!',
                softWrap: true,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              )
            : const SizedBox(),
        GestureDetector(
          onTap: onTap,
          child: isActive
              ? const CircleAvatar(
                  radius: 12,
                  backgroundColor: Color(0xFF3895A4),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15,
                  ),
                )
              : CircleAvatar(
                  radius: 12,
                  backgroundColor: ColorManager.kColorSubTitle,
                ),
        ),
        const SizedBox(width: 10),
        Text(
          'Terms of Service'.tr(context),
          softWrap: true,
          style: Styles.textThin10,
        ),
      ],
    );
  }
}
