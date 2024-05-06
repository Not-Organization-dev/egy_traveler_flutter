import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/assets.dart';
import '../../layout/homeLayout/cubit/cubit.dart';
import '../../core/utils/color_manager.dart';
import '../detailsScreen/DetailsScreenEvent/details_screen_event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllEvents(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).eventModel?.data?.events;
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Near Events'.tr(context),
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
                                ),
                                itemCount: cubit?.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsScreenEvent(
                                            title: 'Near Event',
                                            id: cubit[index].id.toString(),
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
                                                        cubit![index]
                                                                .images?[0] ??
                                                            Assets
                                                                .imageImagetest),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              cubit[index].name!,
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
                                  mainAxisSpacing: 10,
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
