import 'dart:convert';
import 'package:http/http.dart' as http;
import 'network_helper.dart';
import 'network_enums.dart';
import 'network_typedef.dart';

class NetworkService {
  Map<String, String> _getHeaders() {
    return <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YmUyZjBkZDAwZTdhZWU2N2YxYTU2ZWNkZTliOTlhYSIsInN1YiI6IjYzYmJmYTgzYTZlMmQyMDA5MjEwYmUyZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Lvueb0adZlbenjmJsXbTn7TBtU2sm_5Wf0ea8mmyy0I'
    };
  }

  Future<http.Response>? _createRequest(
      {required RequestType requestType,
      required Uri uri,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) {
    if (requestType == RequestType.get) {
      return http.get(uri, headers: headers);
    } else if (requestType == RequestType.post) {
      return http.post(uri, headers: headers, body: jsonEncode(body));
    } else if (requestType == RequestType.put) {
      return http.put(uri, headers: headers, body: jsonEncode(body));
    } else {
      return null;
    }
  }

  Future<R?>? sendRequest<R>({
    required RequestType requestType,
    required String relativeUrl,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    required NetworkCallBack<R> onSuccess,
    required NetworkOnFailureCallBackWithMessage<R> onFailure,
  }) async {
    try {
      final headers = _getHeaders();
      final completeUrl = NetworkHelper.buildUrl(relativeUrl);
      final url = NetworkHelper.concatUrlParameters(
          url: completeUrl, queryParameters: queryParameters);
      final response = await _createRequest(
          requestType: requestType,
          uri: Uri.parse(url),
          headers: headers,
          body: body);
      return NetworkHelper.checkResponse<R>(
          response: response, onSuccess: onSuccess, onFailure: onFailure);
    } catch (e) {
      return null;
    }
  }
}
