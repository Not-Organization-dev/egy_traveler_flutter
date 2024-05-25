import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeGridInfoAndButton extends StatelessWidget {
  const HomeGridInfoAndButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title.tr(context),
          style: Styles.textPrimaryBold22,
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(
            'View All'.tr(context),
            style: Styles.textPrimaryBold16,
          ),
        ),
      ],
    );
  }
}
