import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:appbar_animated/appbar_animated.dart';

import '../../../core/resources/color_manager.dart';
import '../../Recommend/recommend_screen.dart';

class DetailsScreenPlace extends StatefulWidget {
  const DetailsScreenPlace(
      {super.key, required this.title, required this.id, required this.idr});

  final String title;

  final String id;

  final num idr;
  @override
  State<DetailsScreenPlace> createState() => _DetailsScreenPlaceState();
}

class _DetailsScreenPlaceState extends State<DetailsScreenPlace> {
  @override
  Widget build(BuildContext context) {
    id = widget.id;
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getSavedLanguage()
        ..getPlace(id: widget.id)
        ..getAllRecommend(id: widget.idr),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is SuccessReview) {
            CherryToast.success(
              title: const Text('You  review this place'),
              animationType: AnimationType.fromTop,
            ).show(context);
          } else if (state is ErrorReview) {
            CherryToast.error(
              title: const Text('You have already reviewed this place'),
              animationType: AnimationType.fromTop,
            ).show(context);
          } else if (state is SuccessUserTipsPlace) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.white,
              content: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      'You  add this place to your tips'.tr(context),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ));
/*            var snackBar = SnackBar(
              content: Text('You  add this place to your tips'.tr(context)),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
            /*CherryToast.success(
              title: Text('You  add this place to your tips'.tr(context)),
              animationType: AnimationType.fromTop,
            ).show(context);*/
            HomeCubit.get(context).getPlace(id: widget.id);
          } else if (state is ErrorUserTipsPlace) {
            /*   CherryToast.error(
              title: const Text('You have already add this place to your tips'),
              animationType: AnimationType.fromTop,
            ).show(context);*/
          } else if (state is SuccessRemoveUserTipsPlace) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.white,
              content: Row(
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      'You  remove this place to your tips'.tr(context),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ));
/*            CherryToast.success(
              title: Text('You  remove this place to your tips'.tr(context)),
              animationType: AnimationType.fromTop,
            ).show(context);*/
            HomeCubit.get(context).getPlace(id: widget.id);
          } else if (state is ErrorRemoveUserTipsPlace) {
            CherryToast.error(
              title: const Text('You have already add this place to your tips'),
              animationType: AnimationType.fromTop,
            ).show(context);
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context).placesByIdModel?.data?.place;
          print('widget.id: ${widget.id}');
          print('widget.idr: ${widget.idr}');
          return Scaffold(
            bottomNavigationBar: SizedBox(
              height: 80,
              child: cubit?.isTrip == true
                  ? Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state is! LoadingRemoveUserTipsPlace,
                      widgetBuilder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.kColorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              maximumSize: const Size(double.infinity, 50),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: () {
                              HomeCubit.get(context)
                                  .removeUserTipsPlace(id: widget.id);
                            },
                            child: Text(
                              'Remove In My Tips'.tr(context),
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      fallbackBuilder: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                    )
                  : Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state is! LoadingUserTipsPlace,
                      widgetBuilder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.kColorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              maximumSize: const Size(double.infinity, 50),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: () {
                              HomeCubit.get(context)
                                  .addUserTipsPlace(id: widget.id);
                            },
                            child: Text(
                              'Add In My Tips'.tr(context),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      fallbackBuilder: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) => cubit != null,
              widgetBuilder: (BuildContext context) => ScaffoldLayoutBuilder(
                backgroundColorAppBar:
                    const ColorBuilder(Colors.transparent, Color(0xff003441)),
                textColorAppBar: const ColorBuilder(Color(0xff003441)),
                appBarBuilder: _appBar,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: cubit?.image ??
                            'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                        errorWidget: (context, url, error) {
                          // This function is called when there's an error loading the image
                          // You can return a different widget here to be displayed instead of the failed image
                          return Image.network(
                            'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                            fit: BoxFit.cover,
                          );
                        },
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.36,
                        ),
                        // height: 1500,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                          ),
                          color: Color(0xff003441),
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  mouseCursor:
                                      MaterialStateMouseCursor.clickable,
                                  onTap: () async {
                                    Location location = Location();
                                    LocationData locationData;
                                    locationData = await location.getLocation();
                                    setState(() {
                                      launchUrl(Uri.parse(
                                          'https://www.google.com/maps/dir/?api=1&origin=${locationData.latitude},${locationData.longitude}&destination=${cubit!.latitude},${cubit.longitude}'));
                                    });
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          cubit?.location ?? '',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            // color: Color(0xFFE09955),
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  cubit?.description ?? '',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Recommend'.tr(context),
                                      style: TextStyle(
                                        color: ColorManager.kColorPrimary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RecommendScreen(
                                              id: widget.idr,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'View All'.tr(context),
                                        style: TextStyle(
                                          color: ColorManager.kColorPrimary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: 4,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          var cubit = HomeCubit.get(context)
                                              .recommendModel
                                              ?.recommendations?[index];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreenPlace(
                                                title: '',
                                                idr: cubit?.idRe ?? 1,
                                                id: cubit?.id ?? '',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffD9D9D9),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: CachedNetworkImageProvider(HomeCubit
                                                                    .get(
                                                                        context)
                                                                .recommendModel
                                                                ?.recommendations?[
                                                                    index]
                                                                .image ??
                                                            Assets
                                                                .imageImagetest),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  HomeCubit.get(context)
                                                          .recommendModel
                                                          ?.recommendations?[
                                                              index]
                                                          .name ??
                                                      '',
                                                  style: TextStyle(
                                                    color: ColorManager
                                                        .kColorPrimary,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                /*  Text(
                                                  HomeCubit.get(context)
                                                          .recommendModel
                                                          ?.recommendations?[
                                                              index]
                                                          .description ??
                                                      '',
                                                  style: const TextStyle(
                                                    color: Color(0xff606060),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),*/
                                                Text(
                                                  HomeCubit.get(context)
                                                          .recommendModel
                                                          ?.recommendations?[
                                                              index]
                                                          .location ??
                                                      '',
                                                  style: const TextStyle(
                                                    color: Color(0xff003441),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              fallbackBuilder: (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}

String id = '';

Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
  var cubit = HomeCubit.get(context).placesByIdModel?.data?.place;
  return AppBar(
    backgroundColor: colorAnimated.background,
    elevation: 0,
    title: Text(
      cubit?.name ?? '',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 30,
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            if (HomeCubit.get(context).isFav == false) {
              HomeCubit.get(context).addFavoritePlace(id: id);
              HomeCubit.get(context).isFav = true;
            } else {
              HomeCubit.get(context).removeFavoritePlace(id: id);
              HomeCubit.get(context).isFav = false;
            }
          },
          icon: Icon(
            HomeCubit.get(context).isFav == true
                ? Icons.favorite
                : Icons.favorite_border_rounded,
            color: ColorManager.kColorPrimary,
            size: 30,
          )),
    ],
  );
}
