import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenPlace/details_screen_place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeYouMayLikeCarousel extends StatefulWidget {
  const HomeYouMayLikeCarousel({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  _HomeYouMayLikeCarouselState createState() => _HomeYouMayLikeCarouselState();
}

class _HomeYouMayLikeCarouselState extends State<HomeYouMayLikeCarousel> {
  late PageController _pageController;
  late Timer _timer;
  final int _realPageCount = 10000; // Large enough number to simulate infinity
  final int _initialPage = 5000; // Start near the middle

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _initialPage, viewportFraction: .9);
    _pageController.addListener(_resetTimer); // Listen for scroll events
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.removeListener(_resetTimer); // Clean up listener
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: _realPageCount,
        itemBuilder: (context, index) {
          final itemIndex = index % 4; // Change 4 to the actual item count
          return GestureDetector(
            onTap: () {
              _navigateToDetailsScreenPlace(context, itemIndex);
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
                        image: CachedNetworkImageProvider(widget
                                .cubit
                                .placesModelRecomended
                                ?.data
                                ?.places?[itemIndex]
                                .image ??
                            ''),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            widget.cubit.placesModelRecomended?.data
                                    ?.places?[itemIndex].name ??
                                '',
                            maxLines: 2,
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
                            widget.cubit.placesModelRecomended?.data
                                    ?.places?[itemIndex].location ??
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

  void _navigateToDetailsScreenPlace(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreenPlace(
          title: 'You may like',
          idr:
              widget.cubit.placesModelRecomended?.data?.places?[index].idr ?? 0,
          id: widget.cubit.placesModelRecomended?.data?.places?[index].id ?? '',
        ),
      ),
    );
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _resetTimer() {
    if (_timer.isActive) {
      _timer.cancel();
      _startAutoScroll();
    }
  }
}
