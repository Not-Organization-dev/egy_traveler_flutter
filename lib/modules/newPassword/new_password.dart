import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/text_filed_egypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:egytraveler/core/Widgets/custom_button.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';

class NewPassword extends StatelessWidget {
  NewPassword({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController newPasswordConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is UpdatePasswordSuccess) {
            CherryToast.success(
              title: Text(state.successModel['message']),
              animationType: AnimationType.fromTop,
            ).show(context);
            Navigator.pop(context);
          } else if (state is UpdatePasswordError) {
            /* CherryToast.error(

              title:  const Text("Error"),

              displayIcon:  false,

              description: Text(state.errorModel),

              animationType:  AnimationType.fromTop,

              animationDuration:  const Duration(milliseconds:  1000),

              autoDismiss:  true

          ).show(context);*/
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Change Password'.tr(context),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.kColorPrimary,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFiledEgypt(
                                textEditingController:
                                    currentPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                title: 'Current Password',
                                iconData: Icons.lock,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password must not be empty'
                                        .tr(context);
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    HomeCubit.get(context).suffix,
                                  ),
                                ),
                                obscureText: cubit.isPasswordShown,
                              ),
                              if (state is UpdatePasswordError)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.errorModel,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 50,
                              ),
                              TextFiledEgypt(
                                textEditingController: newPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                title: 'New Password',
                                iconData: Icons.lock,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    HomeCubit.get(context).suffix,
                                  ),
                                ),
                                obscureText: cubit.isPasswordShown,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password must not be empty'
                                        .tr(context);
                                  } else if (value.length < 8) {
                                    return 'At least 8 characters'.tr(context);
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              TextFiledEgypt(
                                textEditingController:
                                    newPasswordConfirmController,
                                keyboardType: TextInputType.visiblePassword,
                                title: 'Confirm New Password',
                                iconData: Icons.lock,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    HomeCubit.get(context).suffix,
                                  ),
                                ),
                                obscureText: cubit.isPasswordShown,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password must not be empty'
                                        .tr(context);
                                  } else if (value !=
                                      newPasswordController.text) {
                                    return 'Password does not match'
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
                            state is! UpdatePasswordLoading,
                        widgetBuilder: (context) {
                          return CustomButton(
                              colorButton: ColorManager.kColorPrimary,
                              title: "Verify",
                              colorTitle: Colors.white,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  HomeCubit.get(context).updatePassword(
                                    oldPassword: currentPasswordController.text,
                                    newPassword: newPasswordController.text,
                                    newPasswordConfirm:
                                        newPasswordConfirmController.text,
                                  );
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
            ),
          );
        },
      ),
    );
  }
}
