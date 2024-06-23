import 'package:eatonomy_admin_panel_app/res/colors/colors_app.dart';
import 'package:eatonomy_admin_panel_app/utils/routes/routes.dart';
import 'package:eatonomy_admin_panel_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eatonomy App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsApp.backgroundColorApp,
        ).copyWith(background: ColorsApp.backgroundColorApp),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
