import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:egytraveler/Features/onBoarding/Presentation/view/onboarding_view.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/shared/network/local/cache_helper.dart';

class LanguageConfirmButton extends StatelessWidget {
  const LanguageConfirmButton({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Save selected language code to cache based on user selection
        if (cubit.isLanguageEn == true) {
          context.read<HomeCubit>().cachedLanguageCode('en');
        } else {
          context.read<HomeCubit>().cachedLanguageCode('ar');
        }
        // Save user preference and navigate to onboarding view
        CacheHelper.saveData(
          key: 'SettingsPage',
          value: true,
        ).then((value) {
          if (value == true) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OnBoardingView()));
          }
        });
      },
      child: Center(
        child: Container(
          width: 200,
          height: 56,
          // Styled container for confirm button
          decoration: ShapeDecoration(
            color: ColorManager.kColorPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Center(
            // Text widget for the button label
            child: Text(
              'Done'.tr(context),
              style: Styles.textBold20,
            ),
          ),
        ),
      ),
    );
  }
}
