import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:egytraveler/modules/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(25),
      color: const Color(0xffEAEAEA),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0),
          child: TextFormField(
            readOnly: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ));
            },
            decoration: InputDecoration(
              hintText: 'Search'.tr(context),
              hintStyle:
                  Styles.textThin10.copyWith(color: Colors.grey, fontSize: 16),
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 28,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
