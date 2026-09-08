import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/validators/app_validators.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_button.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:task_manager/widgets/app_snackbar.dart';

import '../providers/task_providers.dart';
class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _dueDate;
  String _priority = 'Medium';
  String _category = 'Work';

  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );

    if (date != null) {
      setState(() {
        _dueDate = date;
      });
    }
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    final data = {
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'is_completed': false,
      'due_date': _dueDate?.toUtc().toIso8601String(),
      'priority': _priority,
      'category': _category,
    };

    setState(() {
      _isSubmitting = true;
    });

    try {
      await ref
          .read(taskNotifierProvider.notifier)
          .createTask(data);

      if (!mounted) return;

      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });

      final message =
          ref.read(taskNotifierProvider).errorMessage ??
              'Unable to create task.';

      AppSnackbar.error(context, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Task',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildHeader(),

                      const SizedBox(height: 24),

                      AuthTextField(
                        controller: _titleController,
                        label: 'Title', 
                        hintText: 'Enter task title', 
                        prefixIcon: Icons.title_rounded,
                        validator: (value) => AppValidators.validate(value),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      TextFormField(
                        controller: _descriptionController,
                        enabled: !_isSubmitting,
                        maxLines: 5,
                        maxLength: 500,
                        textCapitalization:
                            TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText:
                              'Add task details',
                          prefixIcon: Icon(
                            Icons.description_outlined,
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child:
                                DropdownButtonFormField<String>(
                              value: _priority,
                              decoration:
                                  const InputDecoration(
                                labelText: 'Priority',
                                prefixIcon:
                                    Icon(Icons.flag_outlined),
                                border:
                                    OutlineInputBorder(),
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
                                      if (value != null) {
                                        setState(() {
                                          _priority = value;
                                        });
                                      }
                                    },
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child:
                                DropdownButtonFormField<String>(
                              value: _category,
                              decoration:
                                  const InputDecoration(
                                labelText: 'Category',
                                prefixIcon: Icon(
                                  Icons.category_outlined,
                                ),
                                border:
                                    OutlineInputBorder(),
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
                                      if (value != null) {
                                        setState(() {
                                          _category = value;
                                        });
                                      }
                                    },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      InkWell(
                        onTap: _isSubmitting
                            ? null
                            : _pickDate,
                        child: InputDecorator(
                          decoration:
                              const InputDecoration(
                            labelText: 'Due Date',
                            prefixIcon: Icon(
                              Icons
                                  .calendar_today_outlined,
                            ),
                            border:
                                OutlineInputBorder(),
                          ),
                          child: Text(
                            _dueDate == null
                                ? 'No due date selected'
                                : '${_dueDate!.day.toString().padLeft(2, '0')}/'
                                  '${_dueDate!.month.toString().padLeft(2, '0')}/'
                                  '${_dueDate!.year}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Fixed button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: AuthButton(
                onPressed:
                    _isSubmitting ? null : _submit,
                label: _isSubmitting
                    ? 'Creating task...'
                    : 'Create Task',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer
            .withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.add_task_rounded,
            size: 30,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a new task',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Add the details below.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}