import 'package:egytraveler/Features/Auth/Presentation/view/sigin_view.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/sigup_view.dart';
import 'package:egytraveler/core/Widgets/custom_button.dart';
import 'package:egytraveler/generated/assets.dart';
import 'package:flutter/material.dart';

class SignInAndUpViewBody extends StatelessWidget {
  const SignInAndUpViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imageLogin),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.image6),
          const Spacer(),
          CustomButton(
            colorButton: Colors.white,
            title: 'Sign up',
            colorTitle: Colors.black,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpView(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 27,
          ),
          CustomButton(
            colorButton: Colors.black,
            title: 'Sign in',
            colorTitle: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SigInView(),
                ),
              );
            },
          ),
          const Flexible(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
