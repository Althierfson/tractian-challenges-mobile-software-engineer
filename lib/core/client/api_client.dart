import 'package:challenge_tractian/core/client/api_response.dart';

abstract class ApiClient {
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters});
  Future<ApiResponse> post(String path, {Map<String, dynamic>? queryParameters, dynamic body});
  Future<ApiResponse> put(String path, {Map<String, dynamic>? queryParameters, dynamic body});
  Future<ApiResponse> delete(String path, {Map<String, dynamic>? queryParameters});
}
