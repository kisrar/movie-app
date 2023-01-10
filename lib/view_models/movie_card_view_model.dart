import 'package:flutter/material.dart';
import '../views/views.dart';
import '/models/models.dart';

class MovieCardViewModel {
  final Movie _movie;
  MovieCardViewModel({required Movie movie}) : _movie = movie;

  String get posterImageUrl => _movie.posterImageUrl;
  String get largePosterImageUrl => _movie.largePosterImageUrl;

  String get title => _movie.title;
  double get rating => _movie.rating;
  double get popularity => _movie.popularity;
  String get overview => _movie.overview;
  String get releaseDate => _movie.releaseDate;

  void gotoDetailsScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MovieDetailsView(movieCardViewModel: this);
    }));
  }
}
