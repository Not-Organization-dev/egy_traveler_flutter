import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/text_filed_egypt.dart';

class PasswordField extends StatelessWidget {
  final AuthCubit cubit;
  final TextEditingController passwordController;

  const PasswordField({
    required this.cubit,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFiledEgypt(
          textEditingController: passwordController,
          keyboardType: TextInputType.visiblePassword,
          title: 'Password',
          iconData: Icons.lock,
          suffixIcon: IconButton(
            onPressed: () {
              cubit.changePasswordVisibilityIN();
            },
            icon: Icon(cubit.suffixIN),
          ),
          obscureText: cubit.isPasswordShownIN,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password must not be empty'.tr(context);
            } else if (value.length < 8) {
              return 'At least 8 characters'.tr(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        Text(
          'At least 8 characters'.tr(context),
          style: Styles.textThin10,
        ),
      ],
    );
  }
}
