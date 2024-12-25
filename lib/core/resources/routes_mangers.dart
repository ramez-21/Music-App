import 'package:flutter/material.dart';
import 'package:music_app/features/splash/screens/splash_screen.dart';

class RoutesMangers {
  static Map<String, WidgetBuilder> routes = {
    RoutesName.kSplashScreen: (context) => SplashScreen(),
  };
}

class RoutesName {
  static const String kSplashScreen = "/kSplashScreen";
}
