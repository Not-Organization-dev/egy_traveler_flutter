import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUiSmallButton extends StatelessWidget {
  const CustomUiSmallButton({
    super.key,
    required this.icon,
    required this.onTapAction,
  });
  final Widget icon;
  final void Function() onTapAction;

  @override
  Widget build(BuildContext context) {
    //TODO: close button could be removed from other screens
    return InkWell(
      //TODO: need another look here
      // splashColor: Colors.white,
      borderRadius: BorderRadius.circular(50.r),
      onTap: onTapAction,
      child: Container(
        width: 23.w,
        height: 23.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
