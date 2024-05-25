import 'package:flutter/material.dart';

import 'package:egytraveler/core/resources/font_manager.dart';

class TextFromFiledEditProfile extends StatelessWidget {
  const TextFromFiledEditProfile({
    super.key,
    required this.title,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.onChanged,
  });
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFABABAB),
            fontSize: 15,
            fontFamily: FontConstants.fontFamilyRobotoFlex,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: FontConstants.fontFamilyRobotoFlex,
              fontWeight: FontWeight.w600,
            ),
            border: const UnderlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
