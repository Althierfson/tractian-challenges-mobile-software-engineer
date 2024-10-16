import 'package:challenge_tractian/core/dependencies_config/dependencies_config.dart';
import 'package:challenge_tractian/src/data/repositories/company/company_repository_impl.dart';
import 'package:challenge_tractian/src/domain/repositories/company/company_repository.dart';

Future<void> repositoriesConfig() async {
  getIt.registerLazySingleton<CompanyRepository>(() => CompanyRepositoryImpl(datasource: getIt()));
}
