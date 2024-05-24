import 'package:egytraveler/Features/Auth/Presentation/view/widget/sign_up_widgets/form_header.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/sign_up_widgets/password_field.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/sign_up_widgets/sign_up_button.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/widget/text_filed_egypt.dart';

import 'package:egytraveler/Features/Auth/Presentation/view/widget/sign_up_widgets/terms_conditions.dart';

class SignUpViewBody extends StatefulWidget {
  final AuthState state;
  const SignUpViewBody({required this.state, super.key});

  @override
  _SignUpViewBodyState createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isActive = false;
  bool checkbox = false;

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const FormHeader(),
        const SizedBox(height: 25),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                title: 'Email',
                icon: Icons.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email must not be empty'.tr(context);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              _buildTextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                title: 'Name',
                icon: Icons.person,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name must not be empty'.tr(context);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              PasswordField(
                cubit: cubit,
                passwordController: passwordController,
              ),
              const SizedBox(height: 25),
              TermsConditions(
                isActive: isActive,
                checkbox: checkbox,
                onTap: () {
                  setState(() {
                    isActive = !isActive;
                    if (isActive) {
                      checkbox = false;
                    }
                  });
                },
              ),
              const SizedBox(height: 100),
              SignUpButton(
                formKey: formKey,
                isActive: isActive,
                state: widget.state,
                emailController: emailController,
                nameController: nameController,
                passwordController: passwordController,
                onCheckboxChanged: (bool value) {
                  setState(() {
                    checkbox = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String title,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFiledEgypt(
      textEditingController: controller,
      keyboardType: keyboardType,
      title: title,
      iconData: icon,
      validator: validator,
      obscureText: false,
    );
  }
}
