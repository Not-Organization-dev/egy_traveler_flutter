import 'package:flutter/material.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:egytraveler/layout/homeLayout/Presentation/View/Widgets/language_button.dart';
import 'package:egytraveler/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/modules/favorite/favorite_screen.dart';
import 'package:egytraveler/modules/my_trips/my_trips_screen.dart';
import 'package:egytraveler/modules/profile/profile_screen.dart';
import 'package:egytraveler/modules/profile/settings_screen.dart';
import 'package:egytraveler/shared/components/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).drawerTheme.backgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(HomeCubit.get(context)
                                    .userData
                                    ?.data
                                    ?.user
                                    ?.avatar
                                    .toString() ??
                                ''),
                          ),
                        ),
                        const Spacer(),
                        const LanguageButton(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  'Profile'.tr(context),
                  style: Styles.textBold18.copyWith(
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                leading: Icon(
                  Icons.supervised_user_circle,
                  color: Theme.of(context).iconTheme.color,
                  size: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  'Favorites'.tr(context),
                  style: Styles.textBold18.copyWith(
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                leading: Icon(
                  Icons.favorite,
                  color: Theme.of(context).iconTheme.color,
                  size: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).iconTheme.color,
                  size: 30,
                ),
                title: Text(
                  'Settings'.tr(context),
                  style: Styles.textBold18.copyWith(
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  'My Trips'.tr(context),
                  style: Styles.textBold18.copyWith(
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                leading: Icon(
                  Icons.map_sharp,
                  color: Theme.of(context).iconTheme.color,
                  size: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyTripsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Sign Out'.tr(context),
                  style: Styles.textBold18.copyWith(
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).iconTheme.color,
                  size: 30,
                ),
                onTap: () {
                  singOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
