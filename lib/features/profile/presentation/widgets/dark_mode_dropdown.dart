import 'package:flutter/material.dart';

/// Dropdown used to select the application theme.
///
/// This widget does not save anything to Firestore.
/// It only displays the current value and reports
/// the user's selection through [onChanged].
class DarkModeDropdown extends StatelessWidget {
  /// Currently selected theme.
  ///
  /// Expected values:
  /// - system
  /// - light
  /// - dark
  final String value;

  /// Called when the user selects a new theme.
  final ValueChanged<String> onChanged;

  const DarkModeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,

      decoration: const InputDecoration(
        labelText: 'Theme',
        prefixIcon: Icon(
          Icons.palette_outlined,
        ),
        border: OutlineInputBorder(),
      ),

      items: const [
        DropdownMenuItem(
          value: 'system',
          child: Text('System'),
        ),
        DropdownMenuItem(
          value: 'light',
          child: Text('Light'),
        ),
        DropdownMenuItem(
          value: 'dark',
          child: Text('Dark'),
        ),
      ],

      onChanged: (value) {
        if (value == null) return;

        onChanged(value);
      },
    );
  }
}