import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (HomeCubit.get(context).locale.toString() == 'ar') {
          context.read<HomeCubit>().cachedLanguageCode('en');
          HomeCubit.get(context).getAllPlaces(page: 1);
          HomeCubit.get(context).getAllRecomended();
          HomeCubit.get(context).getAllArticles();
        } else {
          context.read<HomeCubit>().cachedLanguageCode('ar');
          HomeCubit.get(context).getAllPlaces(page: 1);
          HomeCubit.get(context).getAllRecomended();
          HomeCubit.get(context).getAllArticles();
        }
      },
      icon: Icon(
        Icons.language_outlined,
        color: ColorManager.kColorPrimary,
        size: 30,
      ),
    );
  }
}
