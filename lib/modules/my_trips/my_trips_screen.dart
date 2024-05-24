import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenPlace/details_screen_place.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getFavorite(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).favoriteModel?.data;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text('My Trips'.tr(context)),
              centerTitle: true,
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'My Trips'.tr(context),
                      style: const TextStyle(
                        color: Color(0xFF003340),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SliverList.builder(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.25),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    cubit!.userTrips?[index].image ??
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.userTrips?[index].name ?? 'Anubis',
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
                                      cubit.userTrips?[index].description ??
                                          'Know more about\nAnubis and his powers.',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xFF5F5F5F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.ellipsis,
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
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color(0xFFE09955),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsScreenPlace(
                                                  title: 'Places',
                                                  id: cubit.userTrips?[index]
                                                          .id ??
                                                      '',
                                                  idr: cubit.userTrips?[index]
                                                          .idr ??
                                                      0,
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
                                          .removeUserTipsPlace(
                                              id: cubit.userTrips?[index].id ??
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
                  itemCount: cubit?.userTrips?.length ?? 0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
