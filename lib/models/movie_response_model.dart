import 'models.dart';

class MovieResponseModel {

final int page;
final int totalPages;
final List<Movie> movies;
  MovieResponseModel({
    required this.page,
    required this.totalPages,
    required this.movies,
  });


  factory MovieResponseModel.fromMap(Map<String, dynamic> map) {
    return MovieResponseModel(
      page: map['page']?.toInt() ?? 0,
      totalPages: map['total_pages']?.toInt() ?? 0,
      movies: List<Movie>.from(map['results']?.map((x) => Movie.fromMap(x))),
    );
  }
}
