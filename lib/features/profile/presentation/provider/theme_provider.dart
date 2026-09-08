import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the theme selected by the user on the Profile screen.
///
/// Possible values:
/// - system
/// - light
/// - dark
///
/// This provider only holds the current UI selection.
/// Firestore is updated when the user taps "Save Changes".
final selectedThemeProvider = NotifierProvider<SelectedThemeNotifier, String>(() {
  return SelectedThemeNotifier();
});

/// A [Notifier] that holds the currently selected theme.
class SelectedThemeNotifier extends Notifier<String> {
  /// Initializes the notifier with the default theme value.
  @override
  String build() {
    return 'system';
  }
  
  /// Updates the currently selected theme.
  void updateTheme(String theme) {
    state = theme;
  }
}