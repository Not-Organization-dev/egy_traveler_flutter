import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:egytraveler/Features/Language/Presentaion/View/widget/custom_choose_language.dart';
import 'package:egytraveler/Features/Language/Presentaion/View/widget/language_confirm_button.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';

class LanguageScreenViewBody extends StatelessWidget {
  const LanguageScreenViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // BlocConsumer to listen for state changes and rebuild UI accordingly
    return BlocConsumer<HomeCubit, HomeStates>(
      // Builder for building the UI based on current state
      listener: (context, state) {},
      builder: (context, state) {
        // Getting the cubit instance from the context
        var cubit = HomeCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text widget to display "Language" with translation
            Text(
              'Language'.tr(context),
              style: Styles.textPrimaryBold22,
            ),
            const SizedBox(
              height: 10,
            ),
            // Text widget to display description with translation
            Text(
              'Choose your application preferred language.'.tr(context),
              style: Styles.textRegular14,
            ),
            const SizedBox(
              height: 80,
            ),
            // GestureDetector for English language selection
            GestureDetector(
              onTap: () {
                cubit.changeLanguageEn();
              },
              child: CustomChooseLanguage(
                title: 'English',
                image: Assets.imageFlagUn,
                isChoose: cubit.isLanguageEn,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // GestureDetector for Arabic language selection
            GestureDetector(
              onTap: () {
                cubit.changeLanguageAr();
              },
              child: CustomChooseLanguage(
                title: 'Arabic',
                image: Assets.imageFlagEgypt,
                isChoose: cubit.isLanguageAr,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            // LanguageConfirmButton widget for confirming language selection
            LanguageConfirmButton(cubit: cubit),
          ],
        );
      },
    );
  }
}
