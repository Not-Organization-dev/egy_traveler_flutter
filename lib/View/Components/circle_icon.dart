import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    super.key,
    required this.icon,
  });

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    //TODO: should be tappable, need colored icons somehow.
    return Container(
      height: 68.h,
      width: 68.w,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            width: 1.w,
            color: const Color.fromARGB(134, 158, 158, 158),
          ),
        ),
        color: Colors.transparent,
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
