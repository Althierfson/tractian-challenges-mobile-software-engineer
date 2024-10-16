import 'package:challenge_tractian/core/client/api_client.dart';
import 'package:challenge_tractian/core/client/api_response.dart';
import 'package:dio/dio.dart';

class DioApiClient implements ApiClient {
  final Dio dio;

  DioApiClient({required this.dio}) {
    dio.options.baseUrl = "https://fake-api.tractian.com";
  }

  @override
  Future<ApiResponse> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(path, queryParameters: queryParameters);
      return ApiResponse(statusCode: response.statusCode!, body: response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return ApiResponse(statusCode: response.statusCode!, body: response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> post(String path, {Map<String, dynamic>? queryParameters, body}) async {
    try {
      final response = await dio.post(path, queryParameters: queryParameters, data: body);
      return ApiResponse(statusCode: response.statusCode!, body: response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> put(String path, {Map<String, dynamic>? queryParameters, body}) async {
    try {
      final response = await dio.put(path, queryParameters: queryParameters, data: body);
      return ApiResponse(statusCode: response.statusCode!, body: response.data);
    } catch (e) {
      rethrow;
    }
  }
}
