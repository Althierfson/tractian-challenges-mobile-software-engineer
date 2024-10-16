import 'package:challenge_tractian/core/dependencies_config/dependencies_config.dart';
import 'package:challenge_tractian/core/routes/routes_config.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependeciesConfig();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final routes = RoutesConfiguration.routes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routerConfig: routes,
    );
  }
}
