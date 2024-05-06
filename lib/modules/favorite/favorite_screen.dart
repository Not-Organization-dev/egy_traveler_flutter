import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenPlace/details_screen_place.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../generated/assets.dart';
import '../detailsScreen/DetailsScreenArticles/details_screen_articles.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int valueIndex = 0;
  @override
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getFavorite(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).favoriteModel?.data;
          print(cubit?.favoriteArticles?.length ?? 0);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text('Favourites'.tr(context)),
              centerTitle: true,
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) => cubit != null,
              widgetBuilder: (BuildContext context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: 'Places'.tr(context),
                      ),
                      Tab(
                        text: 'Article'.tr(context),
                      ),
                    ],
                    onTap: (value) {
                      setState(() {
                        valueIndex = value;
                      });
                    },
                  ),
                  valueIndex == 0
                      ? Expanded(
                          child: Container(
                            child: cubit!.favoritePlaces!.isEmpty
                                ? const Center(
                                    child: Text(
                                      'Empty',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Container(
                                            height: 99,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF003340),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: 100,
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,
                                                        color: Colors.black
                                                            .withOpacity(0.25),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        cubit
                                                                .favoritePlaces?[
                                                                    index]
                                                                .image ??
                                                            'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          cubit
                                                                  .favoritePlaces?[
                                                                      index]
                                                                  .name ??
                                                              'Anubis',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          cubit
                                                                  .favoritePlaces?[
                                                                      index]
                                                                  .description ??
                                                              'Know more about\nAnubis and his powers.',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF5F5F5F),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          color:
                                                              Color(0xFFE09955),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DetailsScreenPlace(
                                                                          title:
                                                                              'Places',
                                                                          idr: cubit.favoritePlaces?[index].idr ??
                                                                              0,
                                                                          id: cubit.favoritePlaces?[index].id ??
                                                                              '',
                                                                        )),
                                                          );
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.delete_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () async {
                                                          await HomeCubit.get(
                                                                  context)
                                                              .removeFavoritePlace(
                                                                  id: cubit
                                                                          .favoritePlaces?[
                                                                              index]
                                                                          .id ??
                                                                      '');
                                                          await HomeCubit.get(
                                                                  context)
                                                              .getFavorite();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          cubit.favoritePlaces?.length ?? 0,
                                    ),
                                  ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            child: cubit!.favoriteArticles!.isEmpty
                                ? const Center(
                                    child: Text(
                                      'Empty',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Container(
                                            height: 99,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF003340),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: 100,
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,
                                                        color: Colors.black
                                                            .withOpacity(0.25),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        cubit
                                                                .favoriteArticles?[
                                                                    index]
                                                                .image ??
                                                            'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          cubit
                                                                  .favoriteArticles?[
                                                                      index]
                                                                  .title ??
                                                              'Anubis',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          cubit
                                                                  .favoriteArticles?[
                                                                      index]
                                                                  .hint ??
                                                              'Know more about\nAnubis and his powers.',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF5F5F5F),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          color:
                                                              Color(0xFFE09955),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DetailsScreenArticles(
                                                                          title:
                                                                              'Articles',
                                                                          id: cubit.favoriteArticles?[index].id ??
                                                                              '',
                                                                        )),
                                                          );
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.delete_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () async {
                                                          await HomeCubit.get(
                                                                  context)
                                                              .removeFavoriteArticlePlace(
                                                                  id: cubit
                                                                          .favoriteArticles?[
                                                                              index]
                                                                          .id ??
                                                                      '');
                                                          await HomeCubit.get(
                                                                  context)
                                                              .getFavorite();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          cubit.favoriteArticles?.length ?? 0,
                                    ),
                                  ),
                          ),
                        ),

                  /*      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Places'.tr(context),
                      style: const TextStyle(
                        color: Color(0xFF003340),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),*/
                  /*          Container(
                    height: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: cubit!.favoritePlaces!.isEmpty
                        ? const Center(
                      child: Text(
                        'Empty',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Container(
                            height: 99,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF003340),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black
                                            .withOpacity(0.25),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        cubit.favoritePlaces?[index]
                                            .image ??
                                            Assets.imageImagetest,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.favoritePlaces?[index]
                                              .name ??
                                              'Anubis',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          cubit.favoritePlaces?[index]
                                              .description ??
                                              'Know more about\nAnubis and his powers.',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xFF5F5F5F),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons
                                              .arrow_forward_ios_outlined,
                                          color: Color(0xFFE09955),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreenPlace(
                                                      title: 'Places',
                                                      idr: cubit
                                                          .favoritePlaces?[
                                                      index]
                                                          .idr ??
                                                          0,
                                                      id: cubit
                                                          .favoritePlaces?[
                                                      index]
                                                          .id ??
                                                          '',
                                                    )),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outlined,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          await HomeCubit.get(context)
                                              .removeFavoritePlace(
                                              id: cubit
                                                  .favoritePlaces?[
                                              index]
                                                  .id ??
                                                  '');
                                          await HomeCubit.get(context)
                                              .getFavorite();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: cubit.favoritePlaces?.length ?? 0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Article'.tr(context),
                      style: const TextStyle(
                        color: Color(0xFF003340),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: cubit.favoriteArticles!.isEmpty
                        ? const Center(
                      child: Text(
                        'Empty',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Container(
                            height: 99,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF003340),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black
                                            .withOpacity(0.25),
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        cubit.favoriteArticles?[index]
                                            .image ??
                                            Assets.imageImagetest,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.favoriteArticles?[index]
                                              .title ??
                                              'Anubis',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          cubit.favoriteArticles?[index]
                                              .hint ??
                                              'Know more about\nAnubis and his powers.',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xFF5F5F5F),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons
                                              .arrow_forward_ios_outlined,
                                          color: Color(0xFFE09955),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreenArticles(
                                                      title: 'Articles',
                                                      id: cubit
                                                          .favoriteArticles?[
                                                      index]
                                                          .id ??
                                                          '',
                                                    )),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outlined,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          await HomeCubit.get(context)
                                              .removeFavoriteArticlePlace(
                                              id: cubit
                                                  .favoriteArticles?[
                                              index]
                                                  .id ??
                                                  '');
                                          await HomeCubit.get(context)
                                              .getFavorite();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: cubit.favoriteArticles?.length ?? 0,
                    ),
                  ),*/
                ],
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
