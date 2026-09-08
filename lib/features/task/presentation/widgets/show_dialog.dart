import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/task/presentation/providers/task_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/task_providers.dart';

/// Displays the dialog used to create a new task.
void showAddTaskDialog(
  BuildContext context,
  WidgetRef ref,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return const _AddTaskDialog();
    },
  );
}

/// A responsive dialog containing the add-task form.
class _AddTaskDialog extends ConsumerStatefulWidget {
  const _AddTaskDialog();

  @override
  ConsumerState<_AddTaskDialog> createState() =>
      _AddTaskDialogState();
}

class _AddTaskDialogState
    extends ConsumerState<_AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  DateTime? _selectedDueDate;

  String _selectedPriority = 'Medium';
  String _selectedCategory = 'Work';

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  Future<void> _selectDueDate() async {
    final now = DateTime.now();

    final initialDate =
        _selectedDueDate ?? now;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );

    if (selectedDate == null || !mounted) {
      return;
    }

    setState(() {
      _selectedDueDate = selectedDate;
    });
  }

  void _clearDueDate() {
    setState(() {
      _selectedDueDate = null;
    });
  }

  Future<void> _submit() async {
    if (_isSubmitting) {
      return;
    }

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _titleController.text.trim();

    final description =
        _descriptionController.text.trim();

    final data = <String, dynamic>{
      'title': title,

      'description': description.isEmpty
          ? null
          : description,

      'is_completed': false,

      'due_date': _selectedDueDate
          ?.toUtc()
          .toIso8601String(),

      'priority': _selectedPriority,

      'category': _selectedCategory,
    };

    setState(() {
      _isSubmitting = true;
    });

    try {
      await ref
          .read(taskNotifierProvider.notifier)
          .createTask(data);

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
      });

      final message = ref
              .read(taskNotifierProvider)
              .errorMessage ??
          'Unable to create task.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 520,
          maxHeight: 720,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(theme),

              const Divider(height: 1),

              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _buildTitleField(),

                      const SizedBox(height: 18),

                      _buildDescriptionField(),

                      const SizedBox(height: 18),

                      _buildPriorityAndCategory(),

                      const SizedBox(height: 18),

                      _buildDueDateField(),
                    ],
                  ),
                ),
              ),

              const Divider(height: 1),

              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        12,
        18,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.add_task_rounded,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Task',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Add a new task to your list',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Close',
            onPressed: _isSubmitting
                ? null
                : () {
                    Navigator.of(context).pop();
                  },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      autofocus: true,
      enabled: !_isSubmitting,
      textCapitalization:
          TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      maxLength: 100,
      decoration: const InputDecoration(
        labelText: 'Title',
        hintText: 'Enter task title',
        prefixIcon: Icon(
          Icons.title_rounded,
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        final title = value?.trim() ?? '';

        if (title.isEmpty) {
          return 'Please enter a task title';
        }

        if (title.length < 2) {
          return 'Title must contain at least 2 characters';
        }

        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      enabled: !_isSubmitting,
      textCapitalization:
          TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      maxLines: 4,
      maxLength: 500,
      decoration: const InputDecoration(
        labelText: 'Description',
        hintText: 'Add some details (optional)',
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: 70),
          child: Icon(
            Icons.description_outlined,
          ),
        ),
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildPriorityAndCategory() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide =
            constraints.maxWidth >= 380;

        if (isWide) {
          return Row(
            children: [
              Expanded(
                child: _buildPriorityDropdown(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCategoryDropdown(),
              ),
            ],
          );
        }

        return Column(
          children: [
            _buildPriorityDropdown(),
            const SizedBox(height: 16),
            _buildCategoryDropdown(),
          ],
        );
      },
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedPriority,
      decoration: const InputDecoration(
        labelText: 'Priority',
        prefixIcon: Icon(
          Icons.flag_outlined,
        ),
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(
          value: 'Low',
          child: Text('Low'),
        ),
        DropdownMenuItem(
          value: 'Medium',
          child: Text('Medium'),
        ),
        DropdownMenuItem(
          value: 'High',
          child: Text('High'),
        ),
      ],
      onChanged: _isSubmitting
          ? null
          : (value) {
              if (value == null) {
                return;
              }

              setState(() {
                _selectedPriority = value;
              });
            },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: const InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(
          Icons.category_outlined,
        ),
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(
          value: 'Work',
          child: Text('Work'),
        ),
        DropdownMenuItem(
          value: 'Personal',
          child: Text('Personal'),
        ),
        DropdownMenuItem(
          value: 'Shopping',
          child: Text('Shopping'),
        ),
        DropdownMenuItem(
          value: 'Health',
          child: Text('Health'),
        ),
        DropdownMenuItem(
          value: 'General',
          child: Text('General'),
        ),
      ],
      onChanged: _isSubmitting
          ? null
          : (value) {
              if (value == null) {
                return;
              }

              setState(() {
                _selectedCategory = value;
              });
            },
    );
  }

  Widget _buildDueDateField() {
    final hasDate = _selectedDueDate != null;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: _isSubmitting
          ? null
          : _selectDueDate,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Due Date',
          prefixIcon: const Icon(
            Icons.calendar_today_outlined,
          ),
          suffixIcon: hasDate
              ? IconButton(
                  tooltip: 'Clear date',
                  onPressed: _isSubmitting
                      ? null
                      : _clearDueDate,
                  icon: const Icon(
                    Icons.clear,
                  ),
                )
              : null,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          hasDate
              ? _formatDate(_selectedDueDate!)
              : 'No due date',
          style: TextStyle(
            color: hasDate
                ? null
                : Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _isSubmitting
                ? null
                : () {
                    Navigator.of(context).pop();
                  },
            child: const Text('Cancel'),
          ),

          const SizedBox(width: 8),

          FilledButton.icon(
            onPressed: _isSubmitting
                ? null
                : _submit,
            icon: _isSubmitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(
                    Icons.add_rounded,
                  ),
            label: Text(
              _isSubmitting
                  ? 'Creating...'
                  : 'Create Task',
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month =
        date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }
}