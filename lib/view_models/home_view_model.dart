import 'package:flutter/cupertino.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/view_models/view_models.dart';

import '../repo/home_repo.dart';

enum HomeStatus { showLoader, showSearching, showData, showEmpty }

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  @override
  void dispose() {
    searchTEC.dispose();
    super.dispose();
  }

  final HomeRepository _homeRepository;
  List<MovieCardViewModel> movies = [];
  HomeStatus homeStatus = HomeStatus.showLoader;
  bool _showSearchBar = false;
  TextEditingController searchTEC = TextEditingController();

  void showHideSearchBar() {
    _showSearchBar = !_showSearchBar;
    notifyListeners();
  }

  bool get showSearchBar => _showSearchBar;

  Future<void> getPopularMovies() async {
    List<Movie> movieModelList = await _homeRepository.getPopularMovies();
    movies = movieModelList
        .map((movie) => MovieCardViewModel(movie: movie))
        .toList();
    if (movies.isEmpty) {
      homeStatus = HomeStatus.showEmpty;
    } else {
      homeStatus = HomeStatus.showData;
    }
    notifyListeners();
  }

  Future<void> getNewsByKeywords() async {
    homeStatus = HomeStatus.showSearching;
    notifyListeners();
    List<Movie> movieModelList =
        await _homeRepository.searchMovies(searchKey: searchTEC.text);
    movies = movieModelList
        .map((movie) => MovieCardViewModel(movie: movie))
        .toList();
    if (movies.isEmpty) {
      homeStatus = HomeStatus.showEmpty;
    } else {
      homeStatus = HomeStatus.showData;
    }
    notifyListeners();
  }
}
