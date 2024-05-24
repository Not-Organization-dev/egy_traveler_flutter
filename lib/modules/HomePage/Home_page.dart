import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import '../../generated/assets.dart';
import '../../core/utils/color_manager.dart';
import '../articles/articles_screen.dart';
import '../detailsScreen/DetailsScreenArticles/details_screen_articles.dart';
import '../detailsScreen/DetailsScreenPlace/details_screen_place.dart';
import '../places/places_screen.dart';
import '../search/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Container(
            color: const Color(0xff003441),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      '${'Welcome'.tr(context)} , ${HomeCubit.get(context).userData?.data?.user?.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xffEAEAEA),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23.0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SearchScreen(),
                                  ));
                            },
                            controller: searchController,
                            keyboardType: TextInputType.none,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'search';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Search'.tr(context),
                              icon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 28,
                              ),
                              border: InputBorder.none,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*      SliverToBoxAdapter(
                    child: Text(
                      'Recommend'.tr(context),
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 105,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Container(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffD9D9D9),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage( Assets.imageImagetest),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width:10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Alexandria',
                                        style: TextStyle(
                                          color: ColorManager.primary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Text('where you can visit the pyramids \n and ride the camels',
                                        style: TextStyle(
                                          color: Color(0xff606060),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),*/

                  SliverToBoxAdapter(
                    child: Text(
                      'You may like'.tr(context),
                      style: TextStyle(
                        color: ColorManager.kColorPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 105,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreenPlace(
                                      title: 'You may like',
                                      idr: cubit.placesModelRecomended?.data
                                              ?.places?[index].idr ??
                                          0,
                                      id: cubit.placesModelRecomended?.data
                                              ?.places?[index].id ??
                                          ''),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffD9D9D9),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(cubit
                                                .placesModelRecomended
                                                ?.data
                                                ?.places?[index]
                                                .image ??
                                            ''),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            cubit.placesModelRecomended?.data
                                                    ?.places?[index].name ??
                                                '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: ColorManager.kColorPrimary,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            cubit.placesModelRecomended?.data
                                                    ?.places?[index].location ??
                                                '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xff606060),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          'Places'.tr(context),
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
                                builder: (context) => const PlacesScreen(),
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
                  ),
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreenPlace(
                                  title: 'Places',
                                  idr: cubit.placesModel?.data?.places?[index]
                                          .idr ??
                                      0,
                                  id: cubit.placesModel?.data?.places?[index]
                                          .id ??
                                      '',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              cubit.placesModel?.data
                                                      ?.places?[index].image ??
                                                  Assets.imageImagetest),
                                          fit: BoxFit.cover,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    cubit.placesModel?.data?.places?[index]
                                            .name ??
                                        '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorManager.kColorPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  /*   Text(
                                    cubit.placesModel?.data?.places?[index].description ?? '',
                                    style: const TextStyle(
                                      color: Color(0xff606060),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                  ),*/
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    cubit.placesModel?.data?.places?[index]
                                            .location ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
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
                      childCount: 4,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          'Article'.tr(context),
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
                                builder: (context) => const ArticlesScreen(),
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
                  ),
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreenArticles(
                                  title: 'Article',
                                  id: cubit.articlesModel?.data
                                          ?.articles?[index].id ??
                                      '',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              cubit
                                                      .articlesModel
                                                      ?.data
                                                      ?.articles?[index]
                                                      .image ??
                                                  Assets.imageImagetest),
                                          fit: BoxFit.cover,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    cubit.articlesModel?.data?.articles?[index]
                                            .title ??
                                        '',
                                    style: TextStyle(
                                      color: ColorManager.kColorPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    cubit.articlesModel?.data?.articles?[index]
                                            .hint ??
                                        '',
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
                      childCount: 4,
                      // childCount: cubit.articlesModel?.data?.articles?.length,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
