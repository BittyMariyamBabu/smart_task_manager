import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/dashboard/presentation/pages/dashboard_pages.dart';
import 'package:task_manager/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:task_manager/features/profile/presentation/provider/user_profile_provider.dart';
import 'package:task_manager/widgets/error_page.dart';

class ProfileGate extends ConsumerWidget {
  const ProfileGate({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final profileState = ref.watch(currentUserProfileProvider);

    return profileState.when(
      loading: () => const OnboardingPage(),

      error: (error, stackTrace) {
        return ErrorPage(
          message: error.toString(),
        );
      },

      data: (profile) {
        if (profile == null) {
          return const ProfileMissingPage();
        }

        return DashboardPage(
          profile: profile,
        );
      },
    );
  }
}

class ProfileMissingPage extends StatelessWidget {
  const ProfileMissingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Unable to load your profile.',
        ),
      ),
    );
  }
}