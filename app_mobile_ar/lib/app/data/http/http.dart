import 'dart:convert';
import 'dart:io';

import 'package:app_mobile_ar/app/domain/either.dart';
import 'package:http/http.dart';

class Http {
  Http({ required String baseUrl,required Client client}): _client = client, _baseUrl = baseUrl ;
  final String _baseUrl;
  final Client _client;

  Future<Either<HttpFailure, String>> request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    try {
      Uri url = Uri.parse(path.startsWith('http') ? path : '$_baseUrl$path');
   
      if (queryParameters.isNotEmpty) {
        url = url.replace(
          queryParameters: queryParameters,
        );
      }
      headers = {'Content-Type': 'application/json', ...headers};
      late final Response response;
      final bodyString = jsonEncode(body);
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response =
              await _client.post(url, headers: headers, body: bodyString);
          break;
        case HttpMethod.patch:
          response =
              await _client.patch(url, headers: headers, body: bodyString);
          break;
        case HttpMethod.delete:
          response =
              await _client.delete(url, headers: headers, body: bodyString);
          break;
        case HttpMethod.put:
          response = await _client.put(url, headers: headers, body: bodyString);
          break;
      }
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(response.body);
      }

      return Either.left(HttpFailure(statusCode: statusCode));
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        return Either.left(HttpFailure(exception: NetworkException()));
      }
      return Either.left(HttpFailure(exception: e));
    }
  }
}

class HttpFailure {
  HttpFailure({this.statusCode, this.exception});
  final int? statusCode;
  final Object? exception;
}

class NetworkException {}

enum HttpMethod { get, post, patch, delete, put }
