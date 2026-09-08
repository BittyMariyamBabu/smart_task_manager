import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/features/auth/presentation/pages/login_page.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:task_manager/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/dashboard/presentation/widgets/profile_gate.dart';
import 'package:task_manager/widgets/error_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Task Manager',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: ThemeMode.system,
      home: authState.when(
        loading: () => const OnboardingPage(),

        error: (error, stackTrace) {
          return ErrorPage(
            message: error.toString(),
          );
        },

        data: (user) {
          debugPrint('AUTH USER: $user');
          if (user == null) {
            return const LoginPage();
          }

          return const ProfileGate();
        },
      ),
    );
  }
}
