import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/assets.dart';
import '../../layout/homeLayout/cubit/cubit.dart';
import '../../core/utils/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:number_paginator/number_paginator.dart';

import '../detailsScreen/DetailsScreenPlace/details_screen_place.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  var selectedPageNumber = 1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllPlaces(page: selectedPageNumber),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).placesModel?.data?.places;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xff003441),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFE09955),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Places'.tr(context),
                  style: const TextStyle(
                    color: Color(0xFFE09955),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Places'.tr(context),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFE09955),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),*/
                    const SizedBox(
                      height: 8,
                    ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (BuildContext context) =>
                            cubit != null,
                        widgetBuilder: (BuildContext context) => Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: cubit?.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsScreenPlace(
                                            title: 'Places',
                                            id: cubit[index].id.toString(),
                                            idr: cubit[index].idr ?? 0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                        cubit![index].image ??
                                                            'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              cubit[index].name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color:
                                                    ColorManager.kColorPrimary,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            /*Expanded(
                                          child: Text(
                                            cubit[index].description!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xff606060),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),*/
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              cubit[index].location!,
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
                        fallbackBuilder: (BuildContext context) => Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                ),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Skeletonizer(
                                    enabled: true,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const Text(
                                          'cubit?[index].name ?? ' '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )),
                  ],
                ),
              ),

              bottomNavigationBar: NumberPaginator(
                // by default, the paginator shows numbers as center content
                numberPages: 24,
                onPageChange: (int pageNumber) {
                  HomeCubit.get(context).getAllPlaces(page: pageNumber);
                  setState(() {
                    selectedPageNumber = pageNumber;
                  });
                },
                // show/hide the prev/next buttons
                showPrevButton: true,
                showNextButton: true, // defaults to true

                config: const NumberPaginatorUIConfig(
                  buttonSelectedBackgroundColor: Colors.amber,
                  buttonUnselectedForegroundColor: Colors.white,
                  buttonSelectedForegroundColor: Colors.white,
                  // buttonSelectedBackgroundColor: ColorManager.primary,
                ),
                // custom content of the prev/next buttons, maintains their behavior
                // nextButtonContent: Icon(Icons.arrow_right_alt),
                // custom prev/next buttons using builder (ignored if showPrevButton/showNextButton is false)
                // prevButtonBuilder: (context) => TextButton(
                //   onPressed:
                //       () {}, // _controller must be passed to NumberPaginator
                //   child: const Row(
                //     children: [
                //       Icon(Icons.chevron_left),
                //       Text("Previous"),
                //     ],
                //   ),
                // ),
              ),

              //Paginator
              // bottomNavigationBar: NumberPaginator(
              //     numberPages: 24,
              //     onPageChange: (int pageNumber) {
              //       HomeCubit.get(context).getAllPlaces(page: pageNumber);
              //       setState(() {
              //         selectedPageNumber = pageNumber;
              //       });
              //     },
              //     initialPage: selectedPageNumber ,
              //     config: const NumberPaginatorUIConfig(
              //       buttonUnselectedForegroundColor: Colors.white,
              //       buttonSelectedForegroundColor: Colors.white,
              //       // buttonSelectedBackgroundColor: ColorManager.primary,
              //     )
              //     /*  onPageChanged: (int pageNumber) {
              //     HomeCubit.get(context).getAllPlaces(page: pageNumber);
              //     setState(() {
              //       selectedPageNumber = pageNumber;
              //     });
              //   },
              //   threshold: 3,
              //   pageTotal:  20,
              //   pageInit: selectedPageNumber, // picked number when init page
              //   colorPrimary: ColorManager.primary,
              //   colorSub: Colors.white,*/
              //     ),
            ),
          );
        },
      ),
    );
  }
}