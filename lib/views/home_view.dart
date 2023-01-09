import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/view_models.dart';
import 'widgets/widgets.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.newspaper),
          onPressed: () {},
        ),
        title: const Text('Top news'),
        actions: [
          IconButton(
            onPressed: viewModel.showHideSearchBar,
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              const SearchBar(),
              Expanded(
                child: _buildBody(),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    if (viewModel.homeStatus == HomeStatus.showLoader) {
      return const Center(child: CircularProgressIndicator());
    } else if (viewModel.homeStatus == HomeStatus.showEmpty) {
      return const Center(
        child: Text('No news found'),
      );
    } else if (viewModel.homeStatus == HomeStatus.showSearching) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Searching news ...'),
      );
    }
    return ListView.builder(
        itemCount: viewModel.movies.length,
        itemBuilder: (context, index) {
          return MovieCard(article: viewModel.movies[index]);
        });
  }
}
