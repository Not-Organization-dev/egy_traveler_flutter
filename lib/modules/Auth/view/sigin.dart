import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:egytraveler/Features/onBoarding/Presentation/view/widget/custom_button.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/homelayout.dart';
import 'package:egytraveler/modules/Auth/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/modules/Auth/view/reset_password.dart';
import 'package:egytraveler/modules/Auth/widget/text_filed_egypt.dart';
import 'package:egytraveler/shared/components/constants.dart';
import 'package:egytraveler/shared/network/local/cache_helper.dart';

class SigInScreen extends StatefulWidget {
  const SigInScreen({super.key});

  @override
  State<SigInScreen> createState() => _SigInScreenState();
}

class _SigInScreenState extends State<SigInScreen> {
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Image.asset(
              Assets.image6,
              width: 100,
              height: 100,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xff57767e),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome'.tr(context),
                    style: TextStyle(
                      color: const Color(0xFF12121D),
                      fontSize: getResponsiveFontSize(context, fontSize: 28),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Sign up with Social of fill the form to continue.'
                        .tr(context),
                    style: TextStyle(
                      color: const Color(0x9912121D),
                      fontSize: getResponsiveFontSize(context, fontSize: 12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 315,
                    height: 0.50,
                    decoration: const BoxDecoration(color: Color(0x4C12121D)),
                  ),
                  const SizedBox(
                    height: 25,
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
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResetPassword()));
                              },
                              child: Text(
                                'Reset Password'.tr(context),
                                style: TextStyle(
                                  color: const Color(0xFF3895A4),
                                  fontSize: getResponsiveFontSize(context,
                                      fontSize: 15),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
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
                                  : const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Color(0x0C12121D),
                                    ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Remember me next time'.tr(context),
                              softWrap: true,
                              style: TextStyle(
                                color: const Color(0x9912121D),
                                fontSize: getResponsiveFontSize(context,
                                    fontSize: 15),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
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
                                    if (formKey.currentState!.validate()) {
                                      print(emailController.text);
                                      print(passwordController.text);
                                      AuthCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
