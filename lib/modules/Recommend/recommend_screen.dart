import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenPlace/details_screen_place.dart';

class RecommendScreen extends StatelessWidget {
  const RecommendScreen({super.key, required this.id});
  final num id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllRecommend(id: id),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).recommendModel?.recommendations;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xff003441),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Recommend'.tr(context),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFE09955),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: cubit?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsScreenPlace(
                                            id: cubit[index].id ?? '',
                                            idr: cubit[index].idRe ?? 0,
                                            title: '',
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
                                                        cubit?[index].image ??
                                                            'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg'),
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
                                              cubit![index].name!,
                                              style: TextStyle(
                                                color:
                                                    ColorManager.kColorPrimary,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              cubit[index].description!,
                                              style: const TextStyle(
                                                color: Color(0xff606060),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 2,
                                            ),
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
            ),
          );
        },
      ),
    );
  }
}
