import 'package:flutter/material.dart';
import '/models/models.dart';

class MovieCardViewModel {
  final Movie _movie;
  MovieCardViewModel({required Movie movie}) : _movie = movie;

  String get posterImageUrl => _movie.posterImageUrl;
  String get title => _movie.title;

  void gotoDetailsScreen(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //   return ArticleDetailsView(detailsUrl: urlToImage);
    // }));
  }
}
