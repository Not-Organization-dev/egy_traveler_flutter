import 'package:flutter/material.dart';

import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/text_filed_egypt.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';

import 'pin_code_widget.dart';

class ValidationForm extends StatelessWidget {
  const ValidationForm({
    super.key,
    required this.otpController,
    required this.passwordController,
    required this.cubit,
    required this.passwordConfirmController,
  });

  final TextEditingController otpController;
  final TextEditingController passwordController;
  final AuthCubit cubit;
  final TextEditingController passwordConfirmController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinCodeWidget(otpController: otpController),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            TextFiledEgypt(
              textEditingController: passwordController,
              keyboardType: TextInputType.visiblePassword,
              title: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  cubit.changePasswordVisibility1();
                },
                icon: Icon(
                  cubit.suffix1,
                ),
              ),
              obscureText: cubit.isPasswordShown1,
              iconData: Icons.lock,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password must not be empty'.tr(context);
                }
                return null;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            TextFiledEgypt(
              textEditingController: passwordConfirmController,
              keyboardType: TextInputType.visiblePassword,
              title: 'Confirm Password',
              iconData: Icons.lock,
              suffixIcon: IconButton(
                onPressed: () {
                  cubit.changePasswordVisibility2();
                },
                icon: Icon(
                  cubit.suffix2,
                ),
              ),
              obscureText: cubit.isPasswordShown2,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password must not be empty'.tr(context);
                }
                return null;
              },
            ),
          ],
        ),
      ],
    );
  }
}
