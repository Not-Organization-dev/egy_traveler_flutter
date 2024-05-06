import 'package:flutter/material.dart';

import '../../core/resources/color_manager.dart';

class Content extends StatelessWidget {
  const Content(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed,
      required this.onTap});
  final IconData icon;
  final String text;

//! made final vars here ///////////////////////////////////////////////
  final void Function()? onPressed;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorManager.kColorPrimary,
            size: 32,
          ),
          const SizedBox(
            width: 13,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}
