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
