import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:appbar_animated/appbar_animated.dart';

import '../../../core/resources/color_manager.dart';

class DetailsScreenArticles extends StatefulWidget {
  const DetailsScreenArticles(
      {super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  State<DetailsScreenArticles> createState() => _DetailsScreenArticlesState();
}

class _DetailsScreenArticlesState extends State<DetailsScreenArticles> {
  @override
  Widget build(BuildContext context) {
    id = widget.id;
    return BlocProvider(
      create: (context) => HomeCubit()..getAllArticlesById(id: widget.id),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).articlesModelById?.data?.article;
          return Scaffold(
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
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.36,
                        ),
                        // height: 1000,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                          ),
                          color: Color(0xff003441),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit?.when ?? '',
                                    style: const TextStyle(
                                      // color: Color(0xFFE09955),
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    cubit?.hint ?? '',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 600,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: cubit?.decription?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          cubit!.decription?[index] ?? '',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        );
                                      },
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
      ),
    );
  }
}

String id = '';

Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
  var cubit = HomeCubit.get(context).articlesModelById?.data?.article;
  return AppBar(
    backgroundColor: colorAnimated.background,
    elevation: 0,
    title: Text(
      cubit?.title ?? '',
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
              HomeCubit.get(context).addFavoriteArticlePlace(id: id);
              HomeCubit.get(context).isFav = true;
            } else {
              HomeCubit.get(context).removeFavoriteArticlePlace(id: id);
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
