import 'package:appbar_animated/appbar_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenPlaceByTrip/details_screen_place_trip.dart';

class DetailsTripsScreen extends StatelessWidget {
  const DetailsTripsScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    idW = id;
    return BlocProvider(
      create: (context) => HomeCubit()..getTrip(id: id),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).tripsByIdModel?.data?.trip;
          return Scaffold(
            body: ScaffoldLayoutBuilder(
              backgroundColorAppBar:
                  const ColorBuilder(Colors.transparent, Color(0xff003441)),
              textColorAppBar: const ColorBuilder(Color(0xff003441)),
              appBarBuilder: _appBar,
              child: SingleChildScrollView(
                child: Stack(
                  children: cubit == null
                      ? [
                          const Center(child: CircularProgressIndicator()),
                        ]
                      : [
                          CachedNetworkImage(
                            imageUrl: cubit.image ??
                                'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.36,
                            ),
                            height: 800,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                              color: Color(0xff003441),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        cubit.location ?? '',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          // color: Color(0xFFE09955),
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: RatingBar.builder(
                              initialRating: cubit.rating!.toDouble() ?? 0.0,
                              itemSize: 30,
                              ignoreGestures: true,
                              minRating: 5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),*/
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    cubit.description ?? '',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      // color: Color(0xFFE09955),
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: cubit.places?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreenPlaceTrip(
                                                  title: 'Place',
                                                  name: cubit.places?[index]
                                                          .name ??
                                                      '',
                                                  description: cubit
                                                          .places?[index]
                                                          .description ??
                                                      '',
                                                  image: cubit.places?[index]
                                                          .image ??
                                                      '',
                                                  location:
                                                      cubit.location ?? '',
                                                  startAt: cubit.places?[index]
                                                          .startAt ??
                                                      '',
                                                  endAt: cubit.places?[index]
                                                          .endAt ??
                                                      '',
                                                  latitude: cubit.places?[index]
                                                          .latitude ??
                                                      '',
                                                  longitude: cubit
                                                          .places?[index]
                                                          .longitude ??
                                                      '',
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                          image: CachedNetworkImageProvider(
                                                              cubit.image ??
                                                                  Assets
                                                                      .imageImagetest),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      /*   child: CachedNetworkImage(
                                            key: UniqueKey(),

                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) =>
                                            const Skeletonizer(
                                              enabled: true,
                                              child: SizedBox(
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                            const Icon(Icons.error),
                                            imageUrl: cubit.placesModel!.data?.places?[index].image ?? Assets.imageImagetest,
                                          ),*/
                                                    ),
                                                  ),
                                                  Text(
                                                    cubit.name!,
                                                    style: TextStyle(
                                                      color: ColorManager
                                                          .kColorPrimary,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    cubit.description!,
                                                    style: const TextStyle(
                                                      color: Color(0xff606060),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    DateFormat('dd', 'en_EG').format(
                                                                DateTime.parse(cubit
                                                                        .places?[
                                                                            index]
                                                                        .endAt ??
                                                                    '')) ==
                                                            DateTime.now().day
                                                        ? 'Completed'
                                                        : 'On Going',
                                                    style: TextStyle(
                                                      color: DateFormat('dd',
                                                                      'en_EG')
                                                                  .format(DateTime.parse(cubit
                                                                          .places?[
                                                                              index]
                                                                          .endAt ??
                                                                      '')) ==
                                                              DateTime.now().day
                                                          ? const Color(
                                                              0xFFCD0101)
                                                          : const Color(
                                                              0xCC008000),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String idW = '';

Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
  var cubit = HomeCubit.get(context).tripsByIdModel?.data?.trip;
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
              HomeCubit.get(context).addFavoritePlace(id: idW);
              HomeCubit.get(context).isFav = true;
            } else {
              HomeCubit.get(context).removeFavoritePlace(id: idW);
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
