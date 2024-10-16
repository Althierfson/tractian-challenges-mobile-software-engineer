import 'package:challenge_tractian/core/dependencies_config/bloc_config.dart';
import 'package:challenge_tractian/core/dependencies_config/core_dependecies_config.dart';
import 'package:challenge_tractian/core/dependencies_config/datasources_config.dart';
import 'package:challenge_tractian/core/dependencies_config/repositories_config.dart';
import 'package:challenge_tractian/core/dependencies_config/usecases_config.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> dependeciesConfig() async {
  await coreDependeciesConfig();
  await datasourcesConfig();
  await repositoriesConfig();
  await usecasesConfig();
  await blocConfig();
}
