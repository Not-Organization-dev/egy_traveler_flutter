import 'package:flutter/material.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/modules/Auth/view/sign_in_and_up.dart';
import 'package:egytraveler/shared/components/constants.dart';
import 'package:egytraveler/shared/network/local/cache_helper.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
    required this.isLast,
  });

  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Saving data to indicate that onboarding is completed
        CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
          // Navigating to the sign in/up screen after onboarding
          if (value == true) {
            navigateFish(context, const SignInAndUp());
          }
        });
      },
      child: Row(
        children: [
          // Displaying 'Start' text if it's the last onboarding screen, otherwise 'Skip'
          Text(
            isLast ? 'Start'.tr(context) : 'skip'.tr(context),
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, fontSize: 22),
              fontWeight: FontWeight.w700,
            ),
          ),
          // Icon for indicating forward navigation
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
