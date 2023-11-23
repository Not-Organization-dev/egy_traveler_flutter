import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUiSmallButton extends StatelessWidget {
  const CustomUiSmallButton({
    super.key,
    required this.icon,
  });
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    //TODO: should be tappable, close button could be removed from other screens
    return Container(
      width: 38.w,
      height: 36.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: icon,
    );
  }
}
