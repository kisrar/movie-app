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
  int currentPage = 1;
  int totalPage = 1;
  bool isSearching = false;
  TextEditingController searchTEC = TextEditingController();

  void showHideSearchBar() {
    _showSearchBar = !_showSearchBar;
    notifyListeners();
  }

  bool get showSearchBar => _showSearchBar;

  void sortMoviesByPopularity(){
    movies.sort((a,b)=>a.popularity.compareTo(b.popularity));
    notifyListeners();
  }

    void sortMoviesByHighestRating(){
    movies.sort((a,b)=>a.rating.compareTo(b.rating));
    notifyListeners();
  }

  Future<void> getPopularMovies(
      {bool isRefresh = false, bool loadingMore = false}) async {
    isSearching = false;

    if (isRefresh) {
      currentPage = 1;
    }
    if (loadingMore) {
      homeStatus = HomeStatus.showLoader;
      notifyListeners();
    }

    MovieResponseModel? movieResponseModel =
        await _homeRepository.getPopularMovies(page: currentPage++);
    totalPage = movieResponseModel?.totalPages ?? 1;
    List<MovieCardViewModel> newMovies = movieResponseModel?.movies
            .map((movie) => MovieCardViewModel(movie: movie))
            .toList() ??
        [];
    if (isRefresh) {
      movies = newMovies;
    } else {
      movies.addAll(newMovies);
    }
    if (movies.isEmpty) {
      homeStatus = HomeStatus.showEmpty;
    } else {
      homeStatus = HomeStatus.showData;
    }
    notifyListeners();
  }

  Future<void> searchMovies({bool loadingMore = false}) async {
    isSearching = true;

    if (loadingMore) {
      homeStatus = HomeStatus.showLoader;
    } else {
      currentPage = 1;
      homeStatus = HomeStatus.showSearching;
    }
    notifyListeners();

    MovieResponseModel? movieResponseModel = await _homeRepository.searchMovies(
        query: searchTEC.text, page: currentPage++);
    totalPage = movieResponseModel?.totalPages ?? 1;
    List<MovieCardViewModel> newMovies = movieResponseModel?.movies
            .map((movie) => MovieCardViewModel(movie: movie))
            .toList() ??
        [];
    if (loadingMore) {
      movies.addAll(newMovies);
    } else {
      movies = newMovies;
    }

    if (movies.isEmpty) {
      homeStatus = HomeStatus.showEmpty;
    } else {
      homeStatus = HomeStatus.showData;
    }
    notifyListeners();
  }
}
