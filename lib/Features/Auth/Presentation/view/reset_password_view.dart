import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:egytraveler/core/Widgets/custom_button.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/verification_view.dart';

import 'package:egytraveler/shared/components/constants.dart';

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
            title: Text(state.successModel['message']),
            animationType: AnimationType.fromTop,
          ).show(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerificationView(email: emailController.value.text)),
          );
        } else if (state is ResetPasswordError) {
          CherryToast.error(
                  title: const Text("Error"),
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Forgot your password?'.tr(context),
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
                    'forgotPassword'.tr(context),
                    style: TextStyle(
                      color: const Color(0x9912121D),
                      fontSize: getResponsiveFontSize(context, fontSize: 12),
                      fontWeight: FontWeight.w400,
                    ),
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
                            labelText: 'Your Phone Number'.tr(context),
                            prefixIcon: const Icon(Icons.email),
                            labelStyle: TextStyle(
                              color: const Color(0xFF12121D),
                              fontSize:
                                  getResponsiveFontSize(context, fontSize: 16),
                              fontWeight: FontWeight.w400,
                            ),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
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
