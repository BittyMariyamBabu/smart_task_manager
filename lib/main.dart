import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/features/auth/presentation/pages/login_page.dart';

Future<void> main() async {
  // Ensure that the Flutter framework is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Task Manager',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: ThemeMode.system,

      home: const LoginPage(),
    );
  }
}
