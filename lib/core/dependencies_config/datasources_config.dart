import 'package:challenge_tractian/core/dependencies_config/dependencies_config.dart';
import 'package:challenge_tractian/src/data/datasources/company/company_datasource.dart';
import 'package:challenge_tractian/src/data/datasources/company/company_datasource_impl.dart';

Future<void> datasourcesConfig() async {
  getIt.registerLazySingleton<CompanyDatasource>(() => CompanyDatasourceImpl(client: getIt()));
}
