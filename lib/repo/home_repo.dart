import 'package:movies_app/models/models.dart';
import '/services/network/network.dart';

abstract class HomeRepository {
  Future<MovieResponseModel?> getPopularMovies({required int page});
  Future<MovieResponseModel?> searchMovies({required String query,required int page});
}

class HomeRepositoryImp implements HomeRepository {
  final NetworkService apiClient;
  HomeRepositoryImp({required this.apiClient});
  @override
  Future<MovieResponseModel?> getPopularMovies({required int page}) async {
    MovieResponseModel? movieResponseModel = await apiClient.sendRequest<MovieResponseModel?>(
        requestType: RequestType.get,
        relativeUrl: EndPoints.popularMovies,
        queryParameters: <String,dynamic>{'page' : page},
        onSuccess: (response) {
          return MovieResponseModel.fromMap(response);
      
        },
        onFailure: (errorType, msg) {
          // return [];
        });
    return movieResponseModel;
  }

  @override
  Future<MovieResponseModel?> searchMovies({required String query,required int page}) async {
    MovieResponseModel? movieResponseModel = await apiClient.sendRequest<MovieResponseModel?>(
        requestType: RequestType.get,
        relativeUrl: EndPoints.searchNews,
        queryParameters: {
          'query': query,
          'page' : page
        },
        onSuccess: (response) {
          return MovieResponseModel.fromMap(response);
        },
        onFailure: (errorType, msg) {
          return null;
        });
    return movieResponseModel;
  }
}
