import 'package:challenge_tractian/core/client/api_client.dart';
import 'package:challenge_tractian/core/client/dio_api_client.dart';
import 'package:challenge_tractian/core/dependencies_config/dependencies_config.dart';
import 'package:dio/dio.dart';

Future<void> coreDependeciesConfig() async {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton<ApiClient>(() => DioApiClient(dio: getIt()));
}
