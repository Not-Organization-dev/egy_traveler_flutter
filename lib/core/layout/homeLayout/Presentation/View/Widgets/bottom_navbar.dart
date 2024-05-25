import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return CurvedNavigationBar(
          index: cubit.currentIndex,
          onTap: (int value) {
            cubit.changeBottomNavIndex(value);
          },
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          height: 60,
          buttonBackgroundColor: Theme.of(context).highlightColor,
          color: const Color.fromRGBO(224, 153, 85, 1),
          animationCurve: Curves.easeInOutSine,
          items: const [
            Icon(Icons.home, size: 30),
            Icon(Icons.location_on_outlined, size: 30),
            Icon(Icons.event, size: 30),
          ],
        );
      },
    );
  }
}
