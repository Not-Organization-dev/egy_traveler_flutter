import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:egytraveler/modules/Auth/cubit/auth_cubit.dart';
import 'package:egytraveler/modules/Auth/widget/custom_button_otp_code.dart';
import 'package:egytraveler/modules/Auth/widget/text_filed_egypt.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../../layout/homeLayout/cubit/cubit.dart';
import '../../../shared/components/constants.dart';
import 'signInAndUp.dart';
import '../../../Features/onBoarding/Presentation/view/widget/custom_button.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key, required this.email});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController otpController = TextEditingController();

  final TextEditingController _controller2 = TextEditingController();

  final TextEditingController _controller3 = TextEditingController();

  final TextEditingController _controller4 = TextEditingController();

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
            title: Text(state.successModel['message']),
            animationType: AnimationType.fromTop,
          ).show(context);
          navigateFish(context, const SignInAndUp());
        } else if (state is OtpError) {
          CherryToast.error(
                  title: const Text("Error"),
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
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Text(
                      'Phone Verification'.tr(context),
                      style: TextStyle(
                        color: const Color(0xFF12121D),
                        fontSize: getResponsiveFontSize(context, fontSize: 26),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Please enter the 4-digit code send to you at'
                          .tr(context),
                      style: TextStyle(
                        color: const Color(0x9912121D),
                        fontSize: getResponsiveFontSize(context, fontSize: 12),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      ' $email',
                      style: TextStyle(
                        color: const Color(0xFF12121D),
                        fontSize: getResponsiveFontSize(context, fontSize: 16),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    /*   TextButton(
                onPressed: () {},
                child: Text(
                  'Resend Code'.tr(context),
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: getResponsiveFontSize(context,fontSize: 16),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),*/

                    const SizedBox(
                      height: 35,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomButtonOtpCode(
                                otpController: otpController,
                              ),
                              CustomButtonOtpCode(
                                otpController: _controller2,
                              ),
                              CustomButtonOtpCode(
                                otpController: _controller3,
                              ),
                              CustomButtonOtpCode(
                                otpController: _controller4,
                              ),
                            ],
                          ),
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
                                    return 'Password must not be empty'
                                        .tr(context);
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              TextFiledEgypt(
                                textEditingController:
                                    passwordConfirmController,
                                keyboardType: TextInputType.visiblePassword,
                                title: 'Password',
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
                                    return 'Password must not be empty'
                                        .tr(context);
                                  }
                                  return null;
                                },
                              ),
                            ],
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
                            state is! OtpLoading,
                        widgetBuilder: (context) {
                          return CustomButton(
                              colorButton: const Color(0xFF3895A4),
                              title: "Verify",
                              colorTitle: Colors.white,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  String otpCode = otpController.text +
                                      _controller2.text +
                                      _controller3.text +
                                      _controller4.text;
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
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
