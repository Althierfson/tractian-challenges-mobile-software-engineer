import 'package:challenge_tractian/core/dependencies_config/dependencies_config.dart';
import 'package:challenge_tractian/src/domain/usecases/company/fetch_assets_company_usecase.dart';
import 'package:challenge_tractian/src/domain/usecases/company/fetch_companies_usecase.dart';

Future<void> usecasesConfig() async {
  getIt.registerLazySingleton(() => FetchCompaniesUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => FetchAssetsCompanyUsecase(repository: getIt()));
}
