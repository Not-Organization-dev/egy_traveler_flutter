import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/utils/styles.dart';
import '../../../../../generated/assets.dart';

class CustomChooseLanguage extends StatelessWidget {
  const CustomChooseLanguage({
    required this.title,
    required this.image,
    required this.isChoose,
    super.key,
  });

  final String title; // Language name
  final String image; // Image asset path for the language flag
  final bool isChoose; // Indicates if the language is selected

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      // Container to hold language selection
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 2,
              color: !isChoose
                  ? ColorManager
                      .kColorIdle // Border color for unselected language
                  : ColorManager
                      .kColorPrimary), // Border color for selected language
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 13,
          ),
          // Container for displaying language flag
          Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 2,
                    color: !isChoose
                        ? ColorManager
                            .kColorIdle // Border color for unselected language
                        : ColorManager
                            .kColorPrimary), // Border color for selected language
                borderRadius: BorderRadius.circular(500),
              ),
            ),
          ),
          const SizedBox(
            width: 23,
          ),
          // Text widget for displaying language title
          Text(
            title.tr(context), // Translate language title
            style: Styles.textRegular18,
          ),
          const Spacer(),
          // Display check mark if language is selected
          if (isChoose)
            SvgPicture.asset(
              Assets.imageCheckCircle,
              color: ColorManager.kColorPrimary,
              width: 32,
              height: 32,
            ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
