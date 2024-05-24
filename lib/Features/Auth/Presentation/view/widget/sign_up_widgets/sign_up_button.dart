import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:egytraveler/core/Widgets/custom_button.dart';
import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';

class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isActive;
  final AuthState state;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final ValueChanged<bool> onCheckboxChanged;

  const SignUpButton({
    required this.formKey,
    required this.isActive,
    required this.state,
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.onCheckboxChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) =>
          state is! RegisterLoadingState,
      widgetBuilder: (context) {
        return CustomButton(
          colorButton: const Color(0xFF3895A4),
          title: 'Sign up',
          colorTitle: Colors.white,
          onTap: () {
            if (formKey.currentState!.validate() && isActive) {
              AuthCubit.get(context).userRegister(
                email: emailController.text,
                name: nameController.text,
                password: passwordController.text,
                passwordConfirm: passwordController.text,
              );
              onCheckboxChanged(false);
            } else {
              if (!isActive) {
                onCheckboxChanged(true);
              }
            }
          },
        );
      },
      fallbackBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
    );
  }
}
