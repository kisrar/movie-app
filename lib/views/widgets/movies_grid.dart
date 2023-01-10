import 'package:flutter/material.dart';
import 'package:movies_app/views/widgets/shimmer_container.dart';
import 'package:provider/provider.dart';

import '../../view_models/view_models.dart';
import 'widgets.dart';

class MoviesGrid extends StatefulWidget {
  const MoviesGrid({super.key});

  @override
  State<MoviesGrid> createState() => _MoviesGridState();
}

class _MoviesGridState extends State<MoviesGrid> {
  ScrollController scrollController = ScrollController();
  late HomeViewModel homeViewModel;
  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (homeViewModel.isSearching) {
          homeViewModel.searchMovies(loadingMore: true);
        } else {
          homeViewModel.getPopularMovies(loadingMore: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: ((context, viewModel, child) {
        if (viewModel.homeStatus == HomeStatus.showEmpty) {
          return const NothingFound();
        } else if (viewModel.homeStatus == HomeStatus.showSearching) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Searching movies ...'),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            viewModel.getPopularMovies(isRefresh: true);
          },
          child: GridView.builder(
              controller: scrollController,
              itemCount: viewModel.homeStatus == HomeStatus.showLoader
                  ? viewModel.movies.length + 10
                  : viewModel.movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                if (index < viewModel.movies.length) {
                  return MovieCard(movie: viewModel.movies[index]);
                } else {
                  return const ShimmerItem();
                }
              }),
        );
      }),
    );
  }
}
