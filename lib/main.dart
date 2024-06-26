import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:egytraveler/Features/Language/Presentaion/View/language_view.dart';
import 'package:egytraveler/Features/onBoarding/Presentation/view/onboarding_view.dart';
import 'package:egytraveler/Features/splash/Presentation/View/splash_view.dart';
import 'package:egytraveler/core/Theme/theme.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/View/homelayout.dart';
import 'package:egytraveler/Features/Auth/Presentation/Manager/AuthCubit/auth_cubit.dart';
import 'package:egytraveler/Features/Auth/Presentation/view/sign_in_and_up_view.dart';
import 'package:egytraveler/shared/bloc_observer.dart';
import 'package:egytraveler/shared/components/constants.dart';
import 'package:egytraveler/shared/network/local/cache_helper.dart';
import 'package:egytraveler/shared/network/remote/dio_helper.dart';

Future<void> main() async {
  Widget widget;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Bloc.observer = MyBlocObserver();
  await DioHelper.inti();
  await CacheHelper.init();
  themeModeCacheHelper = CacheHelper.getData(key: 'theme');
  if (language != null) {
    if (onBoarding != null) {
      if (token != null) {
        widget = const HomeLayout();
      } else {
        widget = const SignInAndUpView();
      }
    } else {
      widget = const OnBoardingView();
    }
  } else {
    widget = const LanguageView();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
/*  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(startWidget: widget,), // Wrap your app
    ),
  );*/
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<HomeCubit>(
            create: (context) => HomeCubit()
              ..getLocation()
              ..getSavedLanguage()
              ..getUserData()
              ..getAllPlaces(page: 1)
              ..getAllRecomended()
              ..getAllArticles()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: HomeCubit.get(context).locale,
            // builder: DevicePreview.appBuilder,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocal != null &&
                    deviceLocal.languageCode == locale.languageCode) {
                  return deviceLocal;
                }
              }
              return supportedLocales.first;
            },
            title: 'EgyTraveler',
            themeMode: themeModeCacheHelper == 'Dark'
                ? ThemeMode.dark
                : themeModeCacheHelper == 'Light'
                    ? ThemeMode.light
                    : ThemeMode.system,
            darkTheme: kDarkThemeData,
            theme: kLightThemeData,
            home: StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off,
                            size: 100,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'no internet',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  HomeCubit.get(context).getUserData();
                  HomeCubit.get(context).getLocation();
                  HomeCubit.get(context).getSavedLanguage();
                  HomeCubit.get(context).getAllPlaces(page: 1);
                  HomeCubit.get(context).getAllRecomended();
                  HomeCubit.get(context).getAllArticles();
                  return SplashView(startWidget: startWidget);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
