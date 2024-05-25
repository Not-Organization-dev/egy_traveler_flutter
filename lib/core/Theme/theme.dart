import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

//initialize app theme

// Dark Theme
final kDarkThemeData = ThemeData.dark().copyWith(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: ColorManager.kDarkColorBackground,
  primaryColor: ColorManager.kColorPrimary,
  textTheme: const TextTheme().copyWith(),
  drawerTheme: const DrawerThemeData().copyWith(
    backgroundColor: ColorManager.kDarkColorBackground,
  ),
  iconTheme: const IconThemeData().copyWith(
    color: Colors.white,
  ),
);

//TODO: Change colors for light theme
//Light Theme
final kLightThemeData = ThemeData.light().copyWith(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: ColorManager.kColorPrimary,
  drawerTheme: const DrawerThemeData().copyWith(
    backgroundColor: ColorManager.kColorSubTitle,
  ),
  iconTheme: const IconThemeData().copyWith(
    color: ColorManager.kDarkColorBackground,
  ),
);
