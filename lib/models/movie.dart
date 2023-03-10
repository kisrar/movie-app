class Movie {
  final String title;
  final String posterImageUrl;
  final String largePosterImageUrl;

  final String overview;
  final double rating;
  final double popularity;
  final String releaseDate;
  Movie({
    required this.title,
    required this.posterImageUrl,
    required this.largePosterImageUrl,

    required this.overview,
    required this.rating,
    required this.popularity,
    required this.releaseDate,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['original_title'] ?? '',
      posterImageUrl: 'https://image.tmdb.org/t/p/w185${map['poster_path']}',
      largePosterImageUrl: 'https://image.tmdb.org/t/p/w400${map['poster_path']}',
      overview: map['overview'] ?? '',
      rating: map['vote_average']?.toDouble() ?? 0.0,
      popularity: map['popularity']?.toDouble() ?? 0.0,
      releaseDate: map['release_date'],
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, posterImageUrl: $posterImageUrl, overview: $overview, rating: $rating, releaseDate: $releaseDate)';
  }
}
