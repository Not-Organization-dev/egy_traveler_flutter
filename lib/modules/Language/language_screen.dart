import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/styles.dart';

import '../../generated/assets.dart';
import '../../layout/homeLayout/cubit/cubit.dart';
import '../../layout/homeLayout/cubit/state.dart';
import 'widget/custom_choose_language.dart';
import 'widget/language_confirm_button.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Language'.tr(context),
                  style: Styles.textPrimaryBold22,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Choose your application preferred language.'.tr(context),
                  style: Styles.textRegular14,
                ),
                const SizedBox(
                  height: 80,
                ),
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
                LanguageConfirmButton(cubit: cubit),
              ],
            ),
          ),
        );
      },
    );
  }
}
