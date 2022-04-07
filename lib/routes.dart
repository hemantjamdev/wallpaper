import 'package:flutter/material.dart';
import 'package:wallpaper/screen/home_screen.dart';
import 'package:wallpaper/screen/image_details.dart';
import 'package:wallpaper/screen/splash_screen.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Splash());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/details':
        return MaterialPageRoute(
          builder: (context) =>
              ImageDetails(map: settings.arguments as Map<dynamic, String>),
        );
    }
  }
}

