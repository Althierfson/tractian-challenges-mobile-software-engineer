import 'package:challenge_tractian/core/dependencies_config/dependencies_config.dart';
import 'package:challenge_tractian/src/data/datasources/company/company_datasource.dart';
import 'package:challenge_tractian/src/data/datasources/company/company_datasource_impl.dart';
import 'package:challenge_tractian/src/data/repositories/company/company_repository_impl.dart';
import 'package:challenge_tractian/src/domain/repositories/company/company_repository.dart';
import 'package:challenge_tractian/src/domain/usecases/company/fetch_assets_company_usecase.dart';
import 'package:challenge_tractian/src/domain/usecases/company/fetch_companies_usecase.dart';
import 'package:challenge_tractian/src/presentation/bloc/home/home_bloc.dart';
import 'package:challenge_tractian/src/presentation/bloc/panel_view/panel_view_bloc.dart';

Future<void> homeDependeciesConfig() async {
  getIt.registerLazySingleton<CompanyDatasource>(() => CompanyDatasourceImpl(client: getIt()));

  getIt.registerLazySingleton<CompanyRepository>(() => CompanyRepositoryImpl(datasource: getIt()));

  getIt.registerLazySingleton(() => FetchCompaniesUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => FetchAssetsCompanyUsecase(repository: getIt()));

  getIt.registerFactory<HomeBloc>(() => HomeBloc(fetchCompaniesUsecase: getIt()));
  getIt.registerFactory<PanelViewBloc>(() => PanelViewBloc(fetchAssetsCompanyUsecase: getIt()));
}
