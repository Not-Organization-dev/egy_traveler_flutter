import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import 'package:egytraveler/core/resources/string_manager.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';
import 'package:egytraveler/model/AtriclesModelById/AtriclesModelById.dart';
import 'package:egytraveler/model/articlesModel/articles_model.dart';
import 'package:egytraveler/model/eventByIdModel/EventByIdModel.dart';
import 'package:egytraveler/model/eventmodel/EventModel.dart';
import 'package:egytraveler/model/favoriteModel/FavoriteModel.dart';
import 'package:egytraveler/model/placeByIdModel/PlaceByIdModel.dart';
import 'package:egytraveler/model/placesModel/PalcesModel.dart';
import 'package:egytraveler/model/recommend/RecommendModel.dart';
import 'package:egytraveler/model/tripsByIdModel/TripsByIdModel.dart';
import 'package:egytraveler/model/tripsModel/TripsModel.dart';
import 'package:egytraveler/model/usermodel/UserModel.dart';
import 'package:egytraveler/modules/Event/event_screen.dart';
import 'package:egytraveler/Features/Home/Presentation/View/home_view.dart';
import 'package:egytraveler/modules/Trips/trips_screen.dart';
import 'package:egytraveler/modules/profile/profile_screen.dart';
import 'package:egytraveler/shared/components/constants.dart';
import 'package:egytraveler/shared/network/local/cache_helper.dart';
import 'package:egytraveler/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  Locale locale = const Locale('en');

  Future<String> getCachedSavedLanguage() async {
    final String? cachedLanguageCode = await CacheHelper.getData(key: 'LOCALE');
    if (cachedLanguageCode != null) {
      debugPrint('cachedLanguageCode');
      return cachedLanguageCode;
    } else {
      debugPrint('cachedLanguageCodeEn');
      return 'en';
    }
  }

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode = await getCachedSavedLanguage();
    locale = Locale(cachedLanguageCode);
    emit(ChangeLocalState());
  }

  Future<void> cachedLanguageCode(String languageCode) async {
    CacheHelper.saveData(key: 'LOCALE', value: languageCode);
    locale = Locale(languageCode);
    emit(ChangeLocalState());
  }

  bool isLanguageAr = false;
  bool isLanguageEn = false;
  void changeLanguageAr() {
    isLanguageAr = true;
    isLanguageEn = false;
    emit(ChangeLanguageArState());
  }

  void changeLanguageEn() {
    isLanguageEn = true;
    isLanguageAr = false;
    emit(ChangeLanguageEnState());
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeView(),
    const TripsScreen(),
    const EventScreen(),
    const ProfileScreen(),
  ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNav());
  }

  UserModel? userData;

  Future<void> getUserData() async {
    emit(LoadingGetUserData());
    await DioHelper.getDate(url: AppStrings.endPointUserData).then((value) {
      userData = UserModel.fromJson(value.data);
      emit(SuccessGetUserData());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetUserData());
    });
  }

  Future<void> updateProfile({
    required String username,
    required String address,
    required String phone,
    required File? avatar,
  }) async {
    emit(EditProfileLoading());
    print(avatar);
    await DioHelper.putData(
      url: AppStrings.endPointEditProfile,
      data: avatar == null
          ? {
              'name': username,
              'address': address,
              'phone': phone,
            }
          : FormData.fromMap({
              'name': username,
              'address': address,
              'phone': phone,
              'avatar': await MultipartFile.fromFile(avatar.path),
            }),
    ).then((value) async {
      emit(EditProfileSuccess(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        print(onError.message);
        print(onError.response);
        print(onError.response!.data);
        emit(EditProfileError(onError.response!.data['message']));
      }
    });
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    emit(UpdatePasswordLoading());
    await DioHelper.putData(
      url: AppStrings.endPointUpdatePassword,
      data: {
        'currentPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': newPasswordConfirm,
      },
    ).then((value) {
      print(value.data);
      emit(UpdatePasswordSuccess(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(UpdatePasswordError(onError.response!.data['message']));
      }
    });
  }

  Future<void> deleteAccount({
    required String password,
  }) async {
    emit(DeleteAccountLoading());
    await DioHelper.deleteData(
      url: AppStrings.endPointDeleteAccount,
      data: {
        'password': password,
      },
    ).then((value) {
      print(value.data);
      emit(DeleteAccountSuccess(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(DeleteAccountError(onError.response!.data['message']));
      }
    });
  }

  //Image
  File? postImage;

  var picker = ImagePicker();

  Future<void> getPostImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(postImage!.path);
      emit(HomePostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(HomePostImagePickedErrorState());
    }
  }

  //event
  EventModel? eventModel;
  Future<void> getAllEvents() async {
    emit(LoadingGetAllEvent());
    await DioHelper.getDate(url: AppStrings.endPointGetAllEvent).then((value) {
      eventModel = EventModel.fromJson(value.data);
      emit(SuccessGetAllEvent());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetAllEvent());
    });
  }

  EventByIdModel? event;
  Future<void> getEvent({required String id}) async {
    emit(LoadingGetEvent());
    await DioHelper.getDate(url: '${AppStrings.endPointGetAllEvent}/$id')
        .then((value) {
      event = EventByIdModel.fromJson(value.data);
      emit(SuccessGetEvent());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetEvent());
    });
  }

  PlacesModel? placesModel;
  Future<void> getAllPlaces({required int page}) async {
    emit(LoadingGetAllPlaces());
    String lang = '';
    await getSavedLanguage().then((value) {
      print(locale);
      lang = locale.toString();
    });
    print(lang);
    await DioHelper.getDate(
            url: '${AppStrings.endPointGetAllPlaces}?page=$page&lang=$lang')
        .then((value) {
      placesModel = PlacesModel.fromJson(value.data);
      emit(SuccessGetAllPlaces());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetAllPlaces());
    });
  }

  PlaceByIdModel? placesByIdModel;
  bool isFav = false;
  Future<void> getPlace({required String id}) async {
    emit(LoadingGetPlace());
    await DioHelper.getDate(url: '${AppStrings.endPointGetAllPlaces}/$id')
        .then((value) {
      placesByIdModel = PlaceByIdModel.fromJson(value.data);
      isFav = placesByIdModel!.data!.place!.isFavorite!;
      emit(SuccessGetPlace());
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
      }
      debugPrint(onError.toString());
      emit(ErrorGetPlace());
    });
  }

  TripsModel? tripsModel;
  Future<void> getAllTrips() async {
    emit(LoadingGetAllTrips());
    await DioHelper.getDate(url: AppStrings.endPointGetAllTrips).then((value) {
      tripsModel = TripsModel.fromJson(value.data);
      emit(SuccessGetAllTrips());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetAllTrips());
    });
  }

  TripsByIdModel? tripsByIdModel;
  Future<void> getTrip({required String id}) async {
    emit(LoadingGetTrips());
    await DioHelper.getDate(url: '${AppStrings.endPointGetAllTrips}/$id')
        .then((value) {
      tripsByIdModel = TripsByIdModel.fromJson(value.data);
      emit(SuccessGetTrips());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetTrips());
    });
  }

  PlacesModel? searchPlacesModel;
  Future<void> getSearchAllPlaces(
      {required String search, required String category}) async {
    emit(LoadingGetSearch());
    String lang = '';
    await getSavedLanguage().then((value) {
      print(locale);
      lang = locale.toString();
    });
    print(lang);
    await DioHelper.getDate(
            url:
                '${AppStrings.endPointGetAllSearch}=$search&category=$category&lang=$lang')
        .then((value) {
      searchPlacesModel = PlacesModel.fromJson(value.data);
      emit(SuccessGetSearch());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetSearch());
    });
  }

  Future<void> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData;
    locationData = await location.getLocation();

    emit(GetLocationState());
  }

  PlacesModel? placesModelRecomended;
  Future<void> getAllRecomended() async {
    emit(LoadingGetAllRecomended());
    String lang = '';
    await getSavedLanguage().then((value) {
      print(locale);
      lang = locale.toString();
    });
    print(lang);
    await DioHelper.getDate(
            url: '${AppStrings.endPointGetAllRecomended}?lang=$lang')
        .then((value) {
      placesModelRecomended = PlacesModel.fromJson(value.data);
      emit(SuccessGetAllRecomended());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetAllRecomended());
    });
  }

  Future<void> getReview({required String id, required rating}) async {
    emit(LoadingReview());
    await DioHelper.postData(
            url: '${AppStrings.endPointReview}${'/$id'}',
            data: {"rating": rating, "comment": "Hello that was nice place"})
        .then((value) {
      emit(SuccessReview(value.data));
    }).catchError((onError) {
      print(onError.toString());
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(ErrorReview(onError.response!.data['message']));
      }
    });
  }

  ArticlesModel? articlesModel;
  Future<void> getAllArticles() async {
    emit(LoadingGetAllArticles());
    await DioHelper.getDate(url: AppStrings.endPointArticles).then((value) {
      articlesModel = ArticlesModel.fromJson(value.data);
      emit(SuccessGetAllArticles());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetAllArticles());
    });
  }

  AtriclesModelById? articlesModelById;
  bool isFavArticle = false;
  Future<void> getAllArticlesById({required String id}) async {
    emit(LoadingGetArticles());
    await DioHelper.getDate(url: '${AppStrings.endPointArticles}/$id')
        .then((value) {
      articlesModelById = AtriclesModelById.fromJson(value.data);
      isFavArticle = articlesModelById!.data!.article!.isFavorite!;
      emit(SuccessGetArticles());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetArticles());
    });
  }

  Future<void> addFavoritePlace({required String id}) async {
    emit(LoadingFavoritePlace());
    await DioHelper.putData(
        url: '${AppStrings.endPointGetAllPlaces}/favorite/$id',
        data: {}).then((value) {
      emit(SuccessFavoritePlace());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorFavoritePlace());
    });
  }

  Future<void> removeFavoritePlace({required String id}) async {
    emit(LoadingRemoveFavoritePlace());
    await DioHelper.deleteData(
        url: '${AppStrings.endPointGetAllPlaces}/favorite/$id',
        data: {}).then((value) {
      emit(SuccessRemoveFavoritePlace());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorRemoveFavoritePlace());
    });
  }

  Future<void> addFavoriteArticlePlace({required String id}) async {
    emit(LoadingFavoriteArticlePlace());
    await DioHelper.putData(
        url: '${AppStrings.endPointArticles}/favorite/$id',
        data: {}).then((value) {
      emit(SuccessFavoriteArticlePlace());
    }).catchError((onError) {
      print(onError.toString());
      if (onError is DioException) {
        print('Here Error');
        debugPrint(onError.response!.data['message']);
      }
      emit(ErrorFavoriteArticlePlace());
    });
  }

  Future<void> removeFavoriteArticlePlace({required String id}) async {
    emit(LoadingRemoveFavoriteArticlePlace());
    await DioHelper.deleteData(
        url: '${AppStrings.endPointArticles}/favorite/$id',
        data: {}).then((value) {
      emit(SuccessRemoveFavoriteArticlePlace());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorRemoveFavoriteArticlePlace());
    });
  }

  FavoriteModel? favoriteModel;
  Future<void> getFavorite() async {
    emit(LoadingGetFavorite());
    await DioHelper.getDate(url: AppStrings.endPointGetFavorite).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(SuccessGetFavorite());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetFavorite());
    });
  }

  Future<void> addUserTipsPlace({required String id}) async {
    emit(LoadingUserTipsPlace());
    await DioHelper.putData(
        url:
            '${AppStrings.endPointGetAllPlaces}/${AppStrings.endPointUserTips}/$id',
        data: {}).then((value) {
      emit(SuccessUserTipsPlace());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorUserTipsPlace());
    });
  }

  Future<void> removeUserTipsPlace({required String id}) async {
    emit(LoadingRemoveUserTipsPlace());
    await DioHelper.deleteData(
        url:
            '${AppStrings.endPointGetAllPlaces}/${AppStrings.endPointUserTips}/$id',
        data: {}).then((value) {
      emit(SuccessRemoveUserTipsPlace());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorRemoveUserTipsPlace());
    });
  }

  ThemeMode themeMode = ThemeMode.system;
  String themeModeText = 'System';
  void changeAppMode({required String theme}) {
    if (theme == 'Dark') {
      themeMode = ThemeMode.dark;
      themeModeText = 'Dark';
      CacheHelper.saveData(key: 'theme', value: 'Dark');
    } else if (theme == 'Light') {
      themeMode = ThemeMode.light;
      themeModeText = 'Light';
      CacheHelper.saveData(key: 'theme', value: 'Light');
    } else {
      themeMode = ThemeMode.system;
      themeModeText = 'System';
      CacheHelper.saveData(key: 'theme', value: 'System');
    }
    themeModeCacheHelper = CacheHelper.getData(key: 'theme');
    emit(ChangeAppMode());
  }

  RecommendModel? recommendModel;

  Future<void> getAllRecommend({required num id}) async {
    emit(LoadingGetAllRecommend());
    await DioHelper.getDateRe(url: 'recommend/$id').then((value) {
      recommendModel = RecommendModel.fromJson(value.data);
      emit(SuccessGetAllRecommend());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetAllRecommend());
    });
  }

  Future<void> discardChange() async {
    postImage = null;
    emit(DiscardChange());
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShown = true;

  void changePasswordVisibility() {
    debugPrint('changePasswordVisibility');
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  IconData suffix1 = Icons.visibility_outlined;

  bool isPasswordShown1 = true;

  void changePasswordVisibility1() {
    isPasswordShown1 = !isPasswordShown1;
    suffix1 = isPasswordShown1
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState1());
  }

  IconData suffix2 = Icons.visibility_outlined;

  bool isPasswordShown2 = true;

  void changePasswordVisibility2() {
    isPasswordShown2 = !isPasswordShown2;
    suffix2 = isPasswordShown2
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState2());
  }
}
