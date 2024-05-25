import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/View/Widgets/bottom_navbar.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/View/Widgets/home_drawer.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';

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
            return WillPopScope(
              onWillPop: () async {
                if (cubit.currentIndex != 0) {
                  cubit.changeBottomNavIndex(0);
                  return false;
                }
                return true;
              },
              child: Scaffold(
                drawer: const CustomDrawer(),
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
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.wifi_off,
                              size: 100,
                            ),
                            Text(
                              'No internet',
                              style: Styles.textRegular18.copyWith(
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                      )
                    : cubit.screens[cubit.currentIndex],
                bottomNavigationBar: const CustomBottomNavigationBar(),
              ),
            );
          },
        );
      },
    );
  }
}
