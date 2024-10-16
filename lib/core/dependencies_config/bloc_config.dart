import 'package:challenge_tractian/core/dependencies_config/dependencies_config.dart';
import 'package:challenge_tractian/src/presentation/bloc/home/home_bloc.dart';
import 'package:challenge_tractian/src/presentation/bloc/panel_view/panel_view_bloc.dart';

Future<void> blocConfig() async {
  getIt.registerFactory<HomeBloc>(() => HomeBloc(fetchCompaniesUsecase: getIt()));
  getIt.registerFactory<PanelViewBloc>(() => PanelViewBloc(fetchAssetsCompanyUsecase: getIt()));
}
