import 'package:cached_network_image/cached_network_image.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenPlace/details_screen_place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeYouMayLikeListView extends StatelessWidget {
  const HomeYouMayLikeListView({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      idr: cubit.placesModelRecomended?.data?.places?[index]
                              .idr ??
                          0,
                      id: cubit
                              .placesModelRecomended?.data?.places?[index].id ??
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            cubit.placesModelRecomended?.data?.places?[index]
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
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            cubit.placesModelRecomended?.data?.places?[index]
                                    .location ??
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
    );
  }
}
