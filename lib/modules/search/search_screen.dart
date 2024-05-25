import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';
import 'package:egytraveler/modules/detailsScreen/DetailsScreenPlace/details_screen_place.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  String? valueName = 'All';
  String valueId = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            HomeCubit.get(context).searchPlacesModel?.data?.places?.clear();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff003441),
              elevation: 0,
              title: Text(
                'Search'.tr(context),
                style: const TextStyle(
                  color: Color(0xFFE09955),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFFE09955),
                ),
                onPressed: () {
                  HomeCubit.get(context)
                      .searchPlacesModel
                      ?.data
                      ?.places
                      ?.clear();
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          PhysicalModel(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffEAEAEA),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23.0),
                                child: TextFormField(
                                  controller: searchController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'search';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: ColorManager.kColorSubTitle,
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
                                    focusedErrorBorder:
                                        const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Positioned(
                            right:
                                HomeCubit.get(context).locale.toString() == 'ar'
                                    ? null
                                    : 0,
                            left:
                                HomeCubit.get(context).locale.toString() == 'ar'
                                    ? 0
                                    : null,
                            child: InkWell(
                              onTap: () {
                                if (searchController.text.isNotEmpty) {
                                  HomeCubit.get(context).getSearchAllPlaces(
                                      search: searchController.text,
                                      category: valueId);
                                } else if (searchController.text.isEmpty) {
                                  print('sadsad');
                                  HomeCubit.get(context)
                                      .searchPlacesModel
                                      ?.data
                                      ?.places
                                      ?.clear();
                                }
                              },
                              child: Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: ColorManager.kColorPrimary,
                                  borderRadius: BorderRadius.horizontal(
                                    right: HomeCubit.get(context)
                                                .locale
                                                .toString() ==
                                            'ar'
                                        ? Radius.zero
                                        : Radius.circular(10),
                                    left: HomeCubit.get(context)
                                                .locale
                                                .toString() ==
                                            'ar'
                                        ? Radius.circular(10)
                                        : Radius.zero,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        value: valueName,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        dropdownColor: ColorManager.kColorPrimary,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 'All',
                            child: Text('All',
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: 'Ecotourism',
                            child: Text('Ecotourism',
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: 'Cultural',
                            child: Text('Cultural',
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: 'Leisure',
                            child: Text('Leisure',
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: 'Medical',
                            child: Text('Medical',
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: 'Sports',
                            child: Text('Sports',
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: 'Religious',
                            child: Text('Religious',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            valueName = value;
                            if (value == 'All') {
                              valueId = '';
                            } else if (value == 'Ecotourism') {
                              valueId = '65f504187bd323b0249c51e0';
                            } else if (value == 'Cultural') {
                              valueId = '65f5041c7bd323b0249c51e2';
                            } else if (value == 'Leisure') {
                              valueId = '65f504237bd323b0249c51e4';
                            } else if (value == 'Medical') {
                              valueId = '65f504277bd323b0249c51e6';
                            } else if (value == 'Sports') {
                              valueId = '65f5042a7bd323b0249c51e8';
                            } else if (value == 'Religious') {
                              valueId = '6619a09681b958670554951b';
                            }
                            if (searchController.text.isNotEmpty) {
                              HomeCubit.get(context).getSearchAllPlaces(
                                  search: searchController.text,
                                  category: valueId);
                            } else if (searchController.text.isEmpty) {
                              HomeCubit.get(context).searchPlacesModel = null;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  if (searchController.text.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          'Empty Search'.tr(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (HomeCubit.get(context)
                              .searchPlacesModel
                              ?.data
                              ?.places!
                              .length ==
                          0 &&
                      searchController.text.isNotEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          'Not found Places please try again'.tr(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: HomeCubit.get(context)
                              .searchPlacesModel
                              ?.data
                              ?.places
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreenPlace(
                                    title: 'Places',
                                    idr: HomeCubit.get(context)
                                            .searchPlacesModel
                                            ?.data
                                            ?.places![index]
                                            .idr ??
                                        0,
                                    id: HomeCubit.get(context)
                                            .searchPlacesModel
                                            ?.data
                                            ?.places![index]
                                            .id ??
                                        '',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        HomeCubit.get(context)
                                                .searchPlacesModel
                                                ?.data
                                                ?.places?[index]
                                                .image ??
                                            'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              HomeCubit.get(context)
                                                  .searchPlacesModel!
                                                  .data!
                                                  .places![index]
                                                  .name!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              HomeCubit.get(context)
                                                      .searchPlacesModel!
                                                      .data!
                                                      .places?[index]
                                                      .location! ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
