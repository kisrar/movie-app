import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../view_models/view_models.dart';

enum SortBy { popularity, highestRated }

class SortDialog extends StatelessWidget {
  const SortDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortBy>(
      color: Colors.white,
      icon: const FaIcon(FontAwesomeIcons.sort),
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: SortBy.popularity,
          child: Text('Sort by Popularity'),
        ),
        PopupMenuItem(
          value: SortBy.highestRated,
          child: Text('Sort by Highest Rated'),
        ),
      ],
      offset: const Offset(0, 50),
      elevation: 2,
      onSelected: (sortBy) {
        if (sortBy == SortBy.popularity) {
          Provider.of<HomeViewModel>(context,listen: false).sortMoviesByPopularity();
        } else {
          Provider.of<HomeViewModel>(context,listen: false).sortMoviesByHighestRating();

        }
      },
    );
  }
}
