class Movie {
  final String title;
  final String posterImageUrl;
  final String overview;
  final double rating;
  final DateTime releaseDate;
  Movie({
    required this.title,
    required this.posterImageUrl,
    required this.overview,
    required this.rating,
    required this.releaseDate,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      posterImageUrl: 'https://image.tmdb.org/t/p/w185${map['posterImageUrl']}',
      overview: map['overview'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      releaseDate: DateTime.parse(map['releaseDate']),
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, posterImageUrl: $posterImageUrl, overview: $overview, rating: $rating, releaseDate: $releaseDate)';
  }
}
