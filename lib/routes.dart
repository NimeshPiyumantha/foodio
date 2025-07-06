import 'package:flutter/material.dart';
import 'package:foodio/screens/foods/food_detail_screen.dart';
import 'package:foodio/screens/onboard_screen/onboarding_screen.dart';
import 'package:foodio/screens/splash_screen/splash_screen.dart';
import 'package:foodio/widgets/main_tab_screen.dart.dart';
import 'screens/authentication/sign_in_screen.dart';
import 'screens/authentication/sign_up_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/home/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case OnboardingScreen.route:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case SignInScreen.route:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case SignUpScreen.route:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case ProfileScreen.route:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case FoodDetailScreen.route:
        return MaterialPageRoute(builder: (_) => const FoodDetailScreen());
      case MainTabScreen.route:
        return MaterialPageRoute(builder: (_) => const MainTabScreen());
      default:
        return MaterialPageRoute(builder: (_) => const FoodDetailScreen());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error Route')),
          body: const Center(child: Text('ERROR Route!')),
        );
      },
    );
  }
}
