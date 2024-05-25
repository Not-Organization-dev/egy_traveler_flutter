import 'package:egytraveler/Features/Auth/Presentation/view/widget/sign_up_widgets/sign_up_view_body.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/View/homelayout.dart';
import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/shared/components/constants.dart';
import 'package:egytraveler/shared/network/local/cache_helper.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _authStateListener,
      builder: (context, state) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80),
            child: SignUpViewBody(state: state),
          ),
        ),
      ),
    );
  }

  void _authStateListener(BuildContext context, AuthState state) async {
    if (state is RegisterSuccessState) {
      await _handleRegisterSuccess(context, state);
    } else if (state is RegisterErrorState) {
      _handleRegisterError(context, state);
    }
  }

  Future<void> _handleRegisterSuccess(
      BuildContext context, RegisterSuccessState state) async {
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

    HomeCubit.get(context).changeBottomNavIndex(0);
    await HomeCubit.get(context).getUserData();

    navigateFish(context, const HomeLayout());
  }

  void _handleRegisterError(BuildContext context, RegisterErrorState state) {
    CherryToast.error(
      title: const Text("Error"),
      displayIcon: false,
      description: Text(state.errorModel!),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);
  }
}
