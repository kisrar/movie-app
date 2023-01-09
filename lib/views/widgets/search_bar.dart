import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/view_models.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, model, child) {
      if (model.showSearchBar) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: model.searchTEC,
            onSubmitted: (_) {
              model.getNewsByKeywords();
            },
            decoration: InputDecoration(
              hintText: 'Search top news by keywords ...',
              border: const OutlineInputBorder(),
              isDense: true,
              prefixIcon: IconButton(
                onPressed: () {
                  model.getNewsByKeywords();
                },
                icon: const Icon(Icons.search),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  model.searchTEC.clear();
                  model.getPopularMovies();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
