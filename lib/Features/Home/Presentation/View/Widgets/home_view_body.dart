import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:egytraveler/Features/Home/Presentation/View/Widgets/home_articles_grid_view.dart';
import 'package:egytraveler/Features/Home/Presentation/View/Widgets/home_grid_info_and_button.dart';
import 'package:egytraveler/Features/Home/Presentation/View/Widgets/home_places_grid_view.dart';
import 'package:egytraveler/Features/Home/Presentation/View/Widgets/home_search_bar.dart';
import 'package:egytraveler/Features/Home/Presentation/View/Widgets/home_you_may_like_list_view.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/utils/styles.dart';
import 'package:egytraveler/modules/articles/articles_screen.dart';
import 'package:egytraveler/modules/places/places_screen.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 22,
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            '${'Welcome'.tr(context)}, ${HomeCubit.get(context).userData?.data?.user?.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.textBold20.copyWith(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        const SliverToBoxAdapter(
          child: HomeSearchBar(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 18,
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            'You may like'.tr(context),
            style: Styles.textPrimaryBold22,
          ),
        ),
        SliverToBoxAdapter(
          child: HomeYouMayLikeListView(cubit: cubit),
        ),
        SliverToBoxAdapter(
          child: HomeGridInfoAndButton(
            title: 'Places',
            onTap: () {
              _navigateToPlacesScreen(context);
            },
          ),
        ),
        HomePlacesGridView(cubit: cubit),
        SliverToBoxAdapter(
          child: HomeGridInfoAndButton(
            title: 'Article',
            onTap: () {
              _navigateToArticlesScreen(context);
            },
          ),
        ),
        HomeArticlesGridView(cubit: cubit),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
      ],
    );
  }

  void _navigateToArticlesScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ArticlesScreen(),
      ),
    );
  }

  void _navigateToPlacesScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlacesScreen(),
      ),
    );
  }
}
