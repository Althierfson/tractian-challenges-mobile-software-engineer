import 'package:challenge_tractian/core/dependencies_config/dependencies_config.dart';
import 'package:challenge_tractian/src/presentation/pages/home/home_page.dart';
import 'package:challenge_tractian/src/presentation/pages/panel_view/panel_view_page.dart';
import 'package:go_router/go_router.dart';

class RoutesConfiguration {
  static GoRouter get routes => GoRouter(routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(homeBloc: getIt()),
        ),
        GoRoute(
            path: '/company/:companyId',
            name: 'company-panel',
            builder: (context, state) {
              final companyId = state.pathParameters['companyId'] as String;
              return PanelViewPage(bloc: getIt(), companyId: companyId);
            }),
      ]);
}
