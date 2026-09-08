import 'package:flutter/material.dart';

/// A widget that displays a recent task card with the task title, date, and completion status.
/// 
/// The [RecentTaskCard] widget takes a [title], [date], and [isCompleted] parameter to display the task information.
class RecentTaskCard extends StatelessWidget {
  /// The title of the task.
  final String title;

  /// The date of the task.
  final String date;

  /// A boolean indicating whether the task is completed or not.
  final bool isCompleted;

  const RecentTaskCard({super.key, 
    required this.title,
    required this.date,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),

        leading: CircleAvatar(
          child: Icon(
            isCompleted
                ? Icons.check
                : Icons.radio_button_unchecked,
          ),
        ),

        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration:
                isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(date),
        ),

        trailing: Icon(
          isCompleted
              ? Icons.check_circle
              : Icons.arrow_forward_ios,
          size: isCompleted ? 22 : 16,
        ),
      ),
    );
  }
}