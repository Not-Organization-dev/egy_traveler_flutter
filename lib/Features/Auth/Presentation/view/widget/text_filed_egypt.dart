import 'package:flutter/material.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';

class TextFiledEgypt extends StatelessWidget {
  TextFiledEgypt(
      {super.key,
      required this.textEditingController,
      required this.keyboardType,
      required this.title,
      required this.iconData,
      required this.validator,
      this.suffixIcon,
      required this.obscureText});
  final TextEditingController textEditingController;
  final TextInputType keyboardType;

  final IconData iconData;
  final String title;

  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: title.tr(context),
        prefixIcon: Icon(iconData),
        suffixIcon: suffixIcon,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
