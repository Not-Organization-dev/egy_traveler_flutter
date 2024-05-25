import 'package:cached_network_image/cached_network_image.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/generated/assets.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenPlace/details_screen_place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePlacesGridView extends StatelessWidget {
  const HomePlacesGridView({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    idr: cubit.placesModel?.data?.places?[index].idr ?? 0,
                    id: cubit.placesModel?.data?.places?[index].id ?? '',
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
                                cubit.placesModel?.data?.places?[index].image ??
                                    Assets.imageImagetest),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      cubit.placesModel?.data?.places?[index].name ?? '',
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
                      cubit.placesModel?.data?.places?[index].location ?? '',
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
    );
  }
}
