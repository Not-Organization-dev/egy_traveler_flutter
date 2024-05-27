import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:egytraveler/core/Widgets/custom_button.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/verification_view.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          CherryToast.success(
            title: Text(
              'Please wait for OTP code.',
              style: Styles.textBold12.copyWith(
                color: ColorManager.kDarkColorBackground,
              ),
            ),
            animationType: AnimationType.fromTop,
          ).show(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerificationView(email: emailController.value.text),
            ),
          );
        } else if (state is ResetPasswordError) {
          CherryToast.error(
                  title: Text(
                    "Something went wrong! Please try again later.",
                    style: Styles.textBold12.copyWith(
                      color: ColorManager.kDarkColorBackground,
                    ),
                  ),
                  displayIcon: false,
                  description: Text(state.errorModel!),
                  animationType: AnimationType.fromTop,
                  animationDuration: const Duration(milliseconds: 1000),
                  autoDismiss: true)
              .show(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Forgot your password?'.tr(context),
                    style: Styles.textBold20,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'forgotPassword'.tr(context),
                    style: Styles.textThin10,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText:
                                'Enter your Email to continue'.tr(context),
                            prefixIcon: const Icon(Icons.email),
                            labelStyle: Styles.textRegular12
                                .copyWith(color: Theme.of(context).hintColor),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email'.tr(context);
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state is! ResetPasswordLoading,
                      widgetBuilder: (context) {
                        return CustomButton(
                            colorButton: const Color(0xFF3895A4),
                            title: "Next",
                            colorTitle: Colors.white,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                AuthCubit.get(context).sendEmailForRestPass(
                                    email: emailController.text);
                              }
                            });
                      },
                      fallbackBuilder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
