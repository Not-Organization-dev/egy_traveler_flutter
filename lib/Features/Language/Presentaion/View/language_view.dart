import 'package:flutter/material.dart';

import 'widget/language_screen_view_body.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
        // LanguageScreenViewBody widget for displaying the language selection UI
        child: LanguageScreenViewBody(),
      ),
    );
  }
}
