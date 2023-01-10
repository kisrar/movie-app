import 'package:flutter/material.dart';
import 'package:movies_app/views/widgets/nothing_found.dart';
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
      backgroundColor: const Color(0xFFF2F4FC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.movie_creation),
          onPressed: () {},
        ),
        title: const Text('The Movies'),
        actions: [
          IconButton(
            onPressed: viewModel.showHideSearchBar,
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          const SearchBar(),
          Expanded(child: MoviesGrid())
          // Expanded(
          //   child: _buildBody(),
          // )
        ],
      ),
    );
  }

  Widget _buildBody() {
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
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return MovieCard(movie: viewModel.movies[index]);
        });
  }
}
