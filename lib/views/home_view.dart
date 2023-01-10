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
        children:  [SearchBar(searchTEC: viewModel.searchTEC), Expanded(child: MoviesGrid())],
      ),
    );
  }
}
