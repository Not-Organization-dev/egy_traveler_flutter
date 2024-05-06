import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.colorButton,
    required this.title,
    required this.colorTitle,
    required this.onTap,
  });
  final Color colorButton;
  final String title;

  final Color colorTitle;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 55,
        decoration: ShapeDecoration(
          color: colorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title.tr(context),
              style: TextStyle(
                color: colorTitle,
                fontSize: getResponsiveFontSize(context, fontSize: 22),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
