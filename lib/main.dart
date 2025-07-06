import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodio/repositories/theme/theme_manager.dart';
import 'package:foodio/routes.dart';
import 'package:foodio/screens/splash_screen/splash_screen.dart';
import 'package:foodio/theme/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';

import 'globals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);



// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeManager themeManager = ThemeManager();

class _MyAppState extends State<MyApp> {
  LogicContextThemeManager theme = LogicContextThemeManager();

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodio',
      initialRoute: SplashScreen.route,
      debugShowCheckedModeBanner: false,
      navigatorKey: globalNavigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: themeManager.themeMode,
    );
  }
}
