import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/sign_in_and_up_view.dart';
import 'package:egytraveler/core/Widgets/custom_button.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:egytraveler/shared/components/constants.dart';

import 'widget/validation_form.dart';

class VerificationView extends StatelessWidget {
  VerificationView({super.key, required this.email});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OtpSuccess) {
          CherryToast.success(
            title: Text(
              state.successModel['message'],
              style: Styles.textBold12.copyWith(
                color: ColorManager.kDarkColorBackground,
              ),
            ),
            animationType: AnimationType.fromTop,
          ).show(context);
          navigateFish(context, const SignInAndUpView());
        } else if (state is OtpError) {
          CherryToast.error(
                  title: Text(
                    "Something went Wrong, Please try again later",
                    style: Styles.textBold12.copyWith(
                      color: ColorManager.kDarkColorBackground,
                    ),
                  ),
                  displayIcon: false,
                  description: Text(state.errorModel),
                  animationType: AnimationType.fromTop,
                  animationDuration: const Duration(milliseconds: 1000),
                  autoDismiss: true)
              .show(context);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 70),
                Text(
                  'Phone Verification'.tr(context),
                  style: Styles.textBold18,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Please enter the 4-digit code send to you at'.tr(context),
                  style: Styles.textThin10,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  ' $email',
                  style: Styles.textBold12.copyWith(
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Form(
                  key: formKey,
                  child: ValidationForm(
                      otpController: otpController,
                      passwordController: passwordController,
                      cubit: cubit,
                      passwordConfirmController: passwordConfirmController),
                ),
                const SizedBox(
                  height: 150,
                ),
                Conditional.single(
                    context: context,
                    conditionBuilder: (BuildContext context) =>
                        state is! OtpLoading,
                    widgetBuilder: (context) {
                      return CustomButton(
                          colorButton: const Color(0xFF3895A4),
                          title: "Verify",
                          colorTitle: Colors.white,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              String otpCode = otpController.text;
                              print(otpCode);
                              AuthCubit.get(context).verify(
                                  email: email,
                                  otpCode: otpCode.toString(),
                                  password: passwordController.text,
                                  passwordConfirm:
                                      passwordConfirmController.text);
                            }
                          });
                    },
                    fallbackBuilder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          ),
        ));
      },
    );
  }
}
