import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/modules/onBoarding/widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../../Auth/view/sigin.dart';
import '../../Auth/view/sigup.dart';



class SignInAndUp extends StatelessWidget {
  const SignInAndUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.imageLogin),
              fit: BoxFit.cover
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
              colorTitle: Colors.black, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => const SignUpScreen() ));
            },
            ),
            const SizedBox(
              height: 27,
            ),
            CustomButton(
              colorButton: Colors.black,
              title: 'Sign in',
              colorTitle: Colors.white, onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) => const SigInScreen() ));
            },
            ),

            const Flexible(
              child: SizedBox(
              ),
            ),
          ],
        ),
      ),
    );
  }
}


