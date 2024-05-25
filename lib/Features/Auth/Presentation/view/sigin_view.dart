import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/sign_in_widgets/reset_password_text_button.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/sign_in_widgets/sign_in_form_header.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/text_filed_egypt.dart';
import 'package:egytraveler/core/Widgets/custom_button.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/Presentation/View/homelayout.dart';
import 'package:egytraveler/shared/components/constants.dart';
import 'package:egytraveler/shared/network/local/cache_helper.dart';

class SigInView extends StatefulWidget {
  const SigInView({super.key});

  @override
  State<SigInView> createState() => _SigInViewState();
}

class _SigInViewState extends State<SigInView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is SingInSuccessState) {
          CherryToast.success(
            title: Text('Welcome back!'.tr(context)),
            animationType: AnimationType.fromTop,
          ).show(context);
          await CacheHelper.saveData(
              key: 'TokenId', value: state.successModel['token']);
          await CacheHelper.saveData(
              key: 'ID', value: state.successModel['data']['user']['_id']);
          token = CacheHelper.getData(key: 'TokenId');
          CacheHelper.getData(key: 'ID');
          if (isActive == true) {
            print('save');
            await CacheHelper.saveData(key: 'isRemember', value: true);
          } else {
            print('not save');
            await CacheHelper.saveData(key: 'isRemember', value: false);
          }

          HomeCubit.get(context).changeBottomNavIndex(0);
          await HomeCubit.get(context).getUserData();
          navigateFish(context, const HomeLayout());
        } else if (state is SingInErrorState) {
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
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SignInFormHeader(),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFiledEgypt(
                          textEditingController: emailController,
                          obscureText: false,
                          title: 'Email',
                          iconData: Icons.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty'.tr(context);
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFiledEgypt(
                          textEditingController: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePasswordVisibilityIN();
                            },
                            icon: Icon(
                              cubit.suffixIN,
                            ),
                          ),
                          obscureText: cubit.isPasswordShownIN,
                          title: 'Password',
                          iconData: Icons.lock,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty'.tr(context);
                            }
                            return null;
                          },
                        ),
                        const ResetPasswordTextButton(),
                        const SizedBox(
                          height: 25,
                        ),
                        _buildRememberMe(context),
                        const SizedBox(
                          height: 100,
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (BuildContext context) =>
                                state is! SingInLoadingState,
                            widgetBuilder: (context) {
                              return CustomButton(
                                  colorButton: const Color(0xFF3895A4),
                                  title: 'Sign in',
                                  colorTitle: Colors.white,
                                  onTap: () {
                                    _sginInFormValidationMethod(context);
                                  });
                            },
                            fallbackBuilder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _sginInFormValidationMethod(BuildContext context) {
    if (formKey.currentState!.validate()) {
      print(emailController.text);
      print(passwordController.text);
      AuthCubit.get(context).userLogin(
          email: emailController.text, password: passwordController.text);
    }
  }

  Row _buildRememberMe(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = !isActive;
            });
          },
          child: isActive == true
              ? const CircleAvatar(
                  radius: 12,
                  backgroundColor: Color(0xFF3895A4),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15,
                  ))
              : CircleAvatar(
                  radius: 12,
                  backgroundColor: ColorManager.kColorIdle,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Remember me next time'.tr(context),
          softWrap: true,
          style: Styles.textThin10,
        ),
      ],
    );
  }
}
