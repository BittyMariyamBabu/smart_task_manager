import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/features/dashboard/presentation/widgets/task_status.dart';
import 'package:task_manager/features/dashboard/presentation/widgets/total_task_card.dart';
import 'package:task_manager/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:task_manager/features/dashboard/presentation/widgets/recent_task.dart';
import 'package:task_manager/features/profile/presentation/pages/profile_page.dart';
import 'package:task_manager/features/profile/data/models/user_model.dart';

/// A dashboard page that displays the user's profile information, total tasks, task status, and recent tasks.
class DashboardPage extends ConsumerWidget {
  /// The user's profile information.
  final UserProfile profile;

  const DashboardPage({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              DashboardHeader(
                name: profile.name,
              ),

              const SizedBox(height: AppSpacing.lg),

              TotalTasksCard(
                totalTasks: 12,
              ),

              const SizedBox(height: AppSpacing.md),

              const TaskStatus(),

              const SizedBox(height: AppSpacing.lg),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Tasks',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (_) => const TaskPage(),
                      //   ),
                      // );
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.sm),

              // --------------------------------------------------
              // Recent Task 1
              // --------------------------------------------------

              const RecentTaskCard(
                title: 'Finish project',
                date: 'Today',
                isCompleted: true,
              ),

              const SizedBox(height: AppSpacing.sm),

              // --------------------------------------------------
              // Recent Task 2
              // --------------------------------------------------

              const RecentTaskCard(
                title: 'Call client',
                date: 'Tomorrow',
                isCompleted: false,
              ),

              const SizedBox(height: AppSpacing.sm),

              // --------------------------------------------------
              // Recent Task 3
              // --------------------------------------------------

              const RecentTaskCard(
                title: 'Prepare presentation',
                date: 'Friday',
                isCompleted: false,
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),

      // ----------------------------------------------------------
      // Add Task Button
      // ----------------------------------------------------------

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => const TaskPage(),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
