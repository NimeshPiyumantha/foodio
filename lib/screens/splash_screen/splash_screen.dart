import 'package:flutter/material.dart';
import 'package:foodio/repositories/shared_preferences_service.dart';
import 'package:foodio/screens/onboard_screen/onboarding_screen.dart';
import 'package:foodio/screens/authentication/sign_in_screen.dart';
import 'package:foodio/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferencesService _prefsService;

  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    _prefsService = await SharedPreferencesService.getInstance();
    
    // Wait for 3 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      await _determineRoute();
    }
  }

  Future<void> _determineRoute() async {
    final isOnboardingCompleted = await _prefsService.isOnboardingCompleted();
    final isUserLoggedIn = await _prefsService.isUserLoggedIn();

    print('=== Route Determination ===');
    print('Onboarding Completed: $isOnboardingCompleted');
    print('User Logged In: $isUserLoggedIn');

    if (!isOnboardingCompleted) {
      // First time user - show onboarding
      print('Navigating to: Onboarding Screen');
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.route);
    } else if (isUserLoggedIn) {
      // User has completed onboarding and is logged in - go to home
      print('Navigating to: Home Screen');
      Navigator.popAndPushNamed(context,'/home');
    } else {
      // User has completed onboarding but not logged in - go to sign in
      print('Navigating to: Sign In Screen');
      Navigator.of(context).pushReplacementNamed(SignInScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fastfood, size: 100, color: Theme.of(context).colorScheme.primary,),
            const SizedBox(height: 24),
            Text(
              'Foodio',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              )
            ),
          ],
        ),
      ),
    );
  }
}
