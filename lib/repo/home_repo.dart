import 'package:movies_app/models/models.dart';
import '/services/network/network.dart';

abstract class HomeRepository {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> searchMovies({required String searchKey});
}

class HomeRepositoryImp implements HomeRepository {
  final NetworkService apiClient;
  HomeRepositoryImp({required this.apiClient});
  @override
  Future<List<Movie>> getPopularMovies() async {
    List<Movie>? movies = await apiClient.sendRequest<List<Movie>>(
        requestType: RequestType.get,
        relativeUrl: EndPoints.popularMovies,
        // queryParameters: {'apiKey' : 'd2d3210e151348ec83015bbd2de5dd67','country' : 'us'},
        onSuccess: (response) {
          return (response['results'] as List)
              .map((articleMap) => Movie.fromMap(articleMap))
              .toList();
        },
        onFailure: (errorType, msg) {
          return [];
        });
    return movies ?? [];
  }

  @override
  Future<List<Movie>> searchMovies({required String searchKey}) async {
    List<Movie>? movies = await apiClient.sendRequest<List<Movie>>(
        requestType: RequestType.get,
        relativeUrl: EndPoints.searchNews,
        queryParameters: {
          'search': searchKey,
        },
        onSuccess: (response) {
          return (response['results'] as List)
              .map((articleMap) => Movie.fromMap(articleMap))
              .toList();
        },
        onFailure: (errorType, msg) {
          return [];
        });
    return movies ?? [];
  }
}
