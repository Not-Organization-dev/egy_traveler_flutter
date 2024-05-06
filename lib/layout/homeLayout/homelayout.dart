import 'package:bottom_bar/bottom_bar.dart';
import 'package:egytraveler/modules/favorite/favorite_screen.dart';
import 'package:egytraveler/modules/profile/settings_screen.dart';
import 'package:egytraveler/shared/components/constants.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../generated/assets.dart';
import '../../modules/my_trips/my_trips_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../core/utils/color_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (BuildContext context, snapshot) {
            return Scaffold(
                drawer: SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Drawer(
                      child: ListView(
                        children: [
                          DrawerHeader(
                            decoration: const BoxDecoration(
                              color: Color(0xff003441),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: const Color(0xff003441),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            HomeCubit.get(context)
                                                    .userData
                                                    ?.data
                                                    ?.user
                                                    ?.avatar
                                                    .toString() ??
                                                ''),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        if (HomeCubit.get(context)
                                                .locale
                                                .toString() ==
                                            'ar') {
                                          context
                                              .read<HomeCubit>()
                                              .cachedLanguageCode('en');
                                          HomeCubit.get(context)
                                              .getAllPlaces(page: 1);
                                          HomeCubit.get(context)
                                              .getAllRecomended();
                                          HomeCubit.get(context)
                                              .getAllArticles();
                                        } else {
                                          context
                                              .read<HomeCubit>()
                                              .cachedLanguageCode('ar');
                                          HomeCubit.get(context)
                                              .getAllPlaces(page: 1);
                                          HomeCubit.get(context)
                                              .getAllRecomended();
                                          HomeCubit.get(context)
                                              .getAllArticles();
                                        }
                                      },
                                      icon: Icon(
                                        Icons.language_outlined,
                                        color: ColorManager.kColorPrimary,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text(
                              'Profile'.tr(context),
                              style: const TextStyle(
                                color: Color(0xff003441),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            leading: const Icon(
                              Icons.supervised_user_circle,
                              color: Color(0xff003441),
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
                              style: const TextStyle(
                                color: Color(0xff003441),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            leading: const Icon(
                              Icons.favorite,
                              color: Color(0xff003441),
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
                            leading: const Icon(
                              Icons.settings,
                              color: Color(0xff003441),
                              size: 30,
                            ),
                            title: Text(
                              'Settings'.tr(context),
                              style: const TextStyle(
                                color: Color(0xff003441),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
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
                              style: const TextStyle(
                                color: Color(0xff003441),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            leading: const Icon(
                              Icons.map_sharp,
                              color: Color(0xff003441),
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
                              style: const TextStyle(
                                color: Color(0xff003441),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            leading: const Icon(
                              Icons.logout,
                              color: Color(0xff003441),
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
                ),
                appBar: AppBar(
                  title: Image.asset(
                    Assets.image6,
                    width: 100,
                    height: 100,
                  ),
                  centerTitle: true,
                  backgroundColor: const Color(0x66D9D9D9),
                  elevation: 0,
                ),
                body: snapshot.data == ConnectivityResult.none
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_off,
                              size: 100,
                              color: Colors.white,
                            ),
                            Text(
                              'no internet',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    : cubit.screens[cubit.currentIndex],
                bottomNavigationBar: PopScope(
                  canPop: cubit.currentIndex != 0 ? false : true,
                  onPopInvoked: (value) {
                    if (cubit.currentIndex != 0) {
                      cubit.changeBottomNavIndex(0);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: BottomBar(
                    backgroundColor: const Color(0xffD9D9D9),
                    itemPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    padding: const EdgeInsets.all(10),
                    curve: Curves.decelerate,
                    duration: const Duration(milliseconds: 500),
                    selectedIndex: cubit.currentIndex,
                    items: [
                      BottomBarItem(
                        title: Text('Home'.tr(context)),
                        inactiveIcon: const Icon(
                          Icons.home,
                        ),
                        icon: const Icon(
                          Icons.home,
                        ),
                        activeColor: const Color(0xFFE09955),
                      ),
                      BottomBarItem(
                        title: Text('Trips'.tr(context)),
                        inactiveIcon: const Icon(
                          Icons.location_on_outlined,
                        ),
                        icon: const Icon(
                          Icons.location_on_outlined,
                        ),
                        activeColor: const Color(0xFFE09955),
                      ),
                      BottomBarItem(
                        title: Text('Event'.tr(context)),
                        inactiveIcon: const Icon(
                          Icons.event,
                        ),
                        icon: const Icon(
                          Icons.event,
                        ),
                        activeColor: const Color(0xFFE09955),
                      ),
                      /*   BottomBarItem(
                              title: Text('Profile'.tr(context)),
                              inactiveIcon: const Icon(
                                Icons.supervised_user_circle,
                              ),
                              icon: const Icon(
                                Icons.supervised_user_circle,
                              ),
                              activeColor: const Color(0xFFE09955),
                            ),*/
                    ],
                    onTap: (int value) {
                      cubit.changeBottomNavIndex(value);
                    },
                  ),
                ));
          },
        );
      },
    );
  }
}
