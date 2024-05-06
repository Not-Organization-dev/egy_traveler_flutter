import 'dart:async';

import 'package:egytraveler/layout/homeLayout/cubit/cubit.dart';
import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/assets.dart';
import '../../../core/utils/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class DetailsScreenEvent extends StatefulWidget {
  const DetailsScreenEvent({super.key, required this.title, required this.id});

  final String title;
  final String id;
  @override
  State<DetailsScreenEvent> createState() => _DetailsScreenEventState();
}

class _DetailsScreenEventState extends State<DetailsScreenEvent> {
  var controller = PageController();
  bool isLast = false;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (controller.page ==
          HomeCubit.get(context).event!.data!.event!.images!.length - 1) {
        controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getEvent(id: widget.id)
        ..getSavedLanguage(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).event?.data?.event;
          return Scaffold(
            body: Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) => cubit != null,
              widgetBuilder: (BuildContext context) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: controller,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      cubit?.images?[index] ??
                                          'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            itemCount: cubit?.images?.length ?? 0,
                            onPageChanged: (index) {
                              if (index == cubit!.images!.length - 1) {
                                setState(() {
                                  isLast = true;
                                });
                              } else {
                                setState(() {
                                  isLast = false;
                                });
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xFFE09955),
                                  ),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  widget.title.tr(context),
                                  style: const TextStyle(
                                    color: Color(0xFFE09955),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        count: cubit?.images?.length ?? 1,
                        effect: ExpandingDotsEffect(
                          expansionFactor: 5,
                          spacing: 8.0,
                          radius: 5,
                          dotWidth: 10.0,
                          dotHeight: 10.0,
                          paintStyle: PaintingStyle.fill,
                          strokeWidth: .1,
                          dotColor: ColorManager.kDotColorActive,
                          activeDotColor: ColorManager.kColorIdle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Text(
                            cubit?.name ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFE09955),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                              ),
                              Text(
                                cubit?.location ?? '',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateFormat('EEE - dd MMMM, yyyy - hh:mm a', '${HomeCubit.get(context).locale.toString()}_EG').format(DateTime.parse(cubit?.startAt ?? ''))}  ',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            DateFormat('EEE - dd MMMM, yyyy - hh:mm a',
                                    '${HomeCubit.get(context).locale.toString()}_EG')
                                .format(DateTime.parse(cubit?.endAt ?? '')),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            cubit?.description ?? '',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
