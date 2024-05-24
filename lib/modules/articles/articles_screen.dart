import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenArticles/details_screen_articles.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllArticles(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).articlesModel?.data?.articles;
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
                    'Article'.tr(context),
                    style: const TextStyle(
                      color: Color(0xFFE09955),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*      const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Article'.tr(context),
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
                                              DetailsScreenArticles(
                                            title: 'Article',
                                            id: cubit[index].id ?? '',
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
                                              cubit[index].title!,
                                              style: TextStyle(
                                                color:
                                                    ColorManager.kColorPrimary,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              cubit[index].hint!,
                                              style: const TextStyle(
                                                color: Color(0xff606060),
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
