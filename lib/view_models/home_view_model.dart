import 'package:flutter/cupertino.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/view_models/view_models.dart';

import '../repo/home_repo.dart';

enum HomeStatus { showLoader, showSearching, showData, showEmpty }

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;
  List<MovieCardViewModel> movies = [];
  HomeStatus homeStatus = HomeStatus.showLoader;
  bool _showSearchBar = false;

  void showHideSearchBar() {
    _showSearchBar = !_showSearchBar;
    notifyListeners();
  }

  bool get showSearchBar => _showSearchBar;

  Future<void> getPopularMovies() async {
    MovieResponseModel? movieResponseModel = await _homeRepository.getPopularMovies();
    movies = movieResponseModel?.movies
        .map((movie) => MovieCardViewModel(movie: movie))
        .toList()??[];
    if (movies.isEmpty) {
      homeStatus = HomeStatus.showEmpty;
    } else {
      homeStatus = HomeStatus.showData;
    }
    notifyListeners();
  }

  Future<void> searchMovies({required String query}) async {
    homeStatus = HomeStatus.showSearching;
    notifyListeners();
    MovieResponseModel? movieResponseModel =
        await _homeRepository.searchMovies(query: query);
    movies = movieResponseModel?.movies
        .map((movie) => MovieCardViewModel(movie: movie))
        .toList()??[];
    if (movies.isEmpty) {
      homeStatus = HomeStatus.showEmpty;
    } else {
      homeStatus = HomeStatus.showData;
    }
    notifyListeners();
  }
}
