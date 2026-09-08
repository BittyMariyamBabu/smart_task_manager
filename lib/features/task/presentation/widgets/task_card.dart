import 'package:flutter/material.dart';
import 'package:task_manager/features/task/data/models/task/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskCard({
    super.key, 
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),

        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) {
            onToggle();
          },
        ),

        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : null,
          ),
        ),

        subtitle: Padding(
          padding:
              const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(task.category),

              if (task.dueDate != null)
                Text(
                  'Due: ${_formatDate(task.dueDate!)}',
                ),

              const SizedBox(height: 4),

              Text(
                task.priority.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _priorityColor(
                    context,
                    task.priority,
                  ),
                ),
              ),
            ],
          ),
        ),

        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ];
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Color _priorityColor(
    BuildContext context,
    String priority,
  ) {
    final colorScheme =
        Theme.of(context).colorScheme;

    switch (priority) {
      case 'high':
        return colorScheme.error;

      case 'medium':
        return colorScheme.primary;

      case 'low':
        return colorScheme.secondary;

      default:
        return colorScheme.onSurface;
    }
  }
}