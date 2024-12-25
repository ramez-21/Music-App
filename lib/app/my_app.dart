import 'package:flutter/material.dart';
import 'package:music_app/core/resources/routes_mangers.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.kSplashScreen,
      routes: RoutesMangers.routes,
    );
  }
}
