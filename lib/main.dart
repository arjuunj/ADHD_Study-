import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme_service.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeService())],
      child: const QuestifyApp(),
    ),
  );
}

class QuestifyApp extends StatelessWidget {
  const QuestifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return MaterialApp(
      title: 'Questify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: themeService.isDarkMode
            ? Brightness.dark
            : Brightness.light,
        scaffoldBackgroundColor: themeService.backgroundColor,
        textTheme: TextTheme(
          bodyMedium: themeService.currentTextStyle,
          bodyLarge: themeService.currentTextStyle,
          displayLarge: themeService.currentTextStyle,
        ),
        useMaterial3: true,
      ),
      // We will create SplashScreen next, for now referencing it will error until created
      home: const SplashScreen(),
    );
  }
}
