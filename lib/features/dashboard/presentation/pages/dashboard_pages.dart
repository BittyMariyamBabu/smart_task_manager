import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:task_manager/features/profile/data/models/user_model.dart';

class DashboardPage extends ConsumerWidget {
  final UserProfile profile;

  const DashboardPage({
    super.key,
    required this.profile,
  });

  Future<void> _logout(BuildContext context,WidgetRef ref) async {
    try {
      await ref.read(authControllerProvider.notifier).logout();
    } catch (_) {
      // Error listener can handle the error.
    }
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              _logout(context, ref);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${profile.name}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(profile.email),

            const SizedBox(height: 24),

            Text(
              'Theme: ${profile.themeMode}',
            ),

            if (profile.createdAt != null) ...[
              const SizedBox(height: 8),
              Text(
                'Created: ${profile.createdAt}',
              ),
            ],
          ],
        ),
      ),
    );
  }
}