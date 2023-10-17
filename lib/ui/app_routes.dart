import 'package:coffee_app/data/models/coffee/coffee_model.dart';
import 'package:coffee_app/ui/auth/register/register_screen.dart';
import 'package:coffee_app/ui/splash/splash_screen.dart';
import 'package:coffee_app/ui/tab_box/home/sub_screens/detail_screen.dart';
import 'package:coffee_app/ui/tab_box/tab_box.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String registerScreen = "/register_screen";
  static const String tabBoxScreen = "/tab_box";
  static const String detailScreen = "/detail_screen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.registerScreen:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case RouteNames.tabBoxScreen:
        return MaterialPageRoute(
          builder: (context) => const TabBox(),
        );
      case RouteNames.detailScreen:
        return MaterialPageRoute(
          builder: (context) => DetailScreen(coffeeModel: settings.arguments as CoffeeModel),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Route not found!")),
          ),
        );
    }
  }
}
