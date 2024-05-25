import 'package:appbar_animated/appbar_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';

class DetailsScreenPlaceTrip extends StatefulWidget {
  const DetailsScreenPlaceTrip({
    super.key,
    required this.title,
    required this.name,
    required this.description,
    required this.image,
    required this.startAt,
    required this.endAt,
    required this.latitude,
    required this.longitude,
    required this.location,
  });

  final String title;
  final String name;
  final String description;
  final String image;
  final dynamic startAt;
  final dynamic endAt;
  final dynamic latitude;

  final String location;
  final dynamic longitude;

  @override
  State<DetailsScreenPlaceTrip> createState() => _DetailsScreenPlaceTripState();
}

class _DetailsScreenPlaceTripState extends State<DetailsScreenPlaceTrip> {
  @override
  Widget build(BuildContext context) {
    nameAppbar = widget.name;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => widget.title.isNotEmpty,
            widgetBuilder: (BuildContext context) => ScaffoldLayoutBuilder(
              backgroundColorAppBar:
                  const ColorBuilder(Colors.transparent, Color(0xff003441)),
              textColorAppBar: const ColorBuilder(Color(0xff003441)),
              appBarBuilder: _appBar,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.image.isNotEmpty
                          ? widget.image
                          : 'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.36,
                      ),
                      height: 700,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                        color: Color(0xff003441),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      widget.location,
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
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 2.3,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      widget.description,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        // color: Color(0xFFE09955),
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
    );
  }
}

String nameAppbar = '';
Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
  return AppBar(
    backgroundColor: colorAnimated.background,
    elevation: 0,
    title: Text(
      nameAppbar ?? '',
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
  );
}
