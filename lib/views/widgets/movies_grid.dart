import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/view_models.dart';
import 'widgets.dart';

class MoviesGrid extends StatefulWidget {
  const MoviesGrid({super.key});

  @override
  State<MoviesGrid> createState() => _MoviesGridState();
}

class _MoviesGridState extends State<MoviesGrid> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: ((context, viewModel, child) {
        if (viewModel.homeStatus == HomeStatus.showLoader) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.homeStatus == HomeStatus.showEmpty) {
          return const NothingFound();
        } else if (viewModel.homeStatus == HomeStatus.showSearching) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Searching movies ...'),
          );
        }
        return GridView.builder(
            itemCount: viewModel.movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return MovieCard(movie: viewModel.movies[index]);
            });
      }),
    );
  }
}
