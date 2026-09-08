import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:task_manager/features/profile/presentation/provider/user_profile_provider.dart';
import 'package:task_manager/features/profile/presentation/widgets/profile_content.dart';
import 'package:task_manager/widgets/app_snackbar.dart';

/// A page that displays the user's profile information and allows
/// them to edit their name, change their theme mode, and log out.
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  /// Currently selected theme.
  ///
  /// This is only the value in the form.
  /// It is saved to Firestore when Save Changes is pressed.
  String _themeMode = 'system';

  /// Prevents profile values from being copied into
  /// the form repeatedly when Riverpod rebuilds the page.
  bool _initialized = false;

  /// Prevents multiple Save operations.
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Copies the Firestore profile into the local form
  /// the first time the profile becomes available.
  void _initializeForm(profile) {
    if (_initialized) {
      return;
    }

    _nameController.text = profile.name;

    _themeMode = profile.themeMode;

    _initialized = true;
  }


  Future<void> _saveProfile() async {
    // Validate form first.
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    // Get the current profile from Riverpod.
    final profileState = ref.read(
      currentUserProfileProvider,
    );

    // Make sure profile has a value.
    if (!profileState.hasValue) {
      AppSnackbar.error(
        context,
        'Profile is still loading.',
      );
      return;
    }

    final profile = profileState.value;

    if (profile == null) {
      AppSnackbar.error(
        context,
        'User profile not found.',
      );
      return;
    }

    // Start loading state.
    setState(() {
      _saving = true;
    });

    try {
      // Get the Riverpod controller.
      final controller = ref.read(
        userProfileControllerProvider.notifier,
      );

      // Update profile information.
      await controller.updateProfile(
        uid: profile.uid,
        name: _nameController.text.trim(),
        email: profile.email,
      );

      // Update theme preference.
      await controller.updateTheme(
        uid: profile.uid,
        themeMode: _themeMode,
      );

      if (!mounted) return;

      AppSnackbar.success(
        context,
        'Profile updated successfully.',
      );
    } catch (e) {
      if (!mounted) return;

      AppSnackbar.error(
        context,
        'Failed to update profile: $e',
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _saving = false;
      });
    }
  }

  Future<void> _logout() async {
    try {
      await ref.read(authControllerProvider.notifier).logout();
    } catch (_) {
      // Authentication state controls navigation.
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch profile.
    //
    // The page rebuilds when the profile changes.
    final profileState = ref.watch(
      currentUserProfileProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: profileState.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return ErrorWidget(
            error,
          );
        },
        data: (profile) {
          if (profile == null) {
            return const Center(
              child: Text(
                'User profile not found.',
              ),
            );
          }

          // Initialize form only once.
          _initializeForm(profile);

          return ProfileContent(
            formKey: _formKey,
            nameController: _nameController,
            emailController: _emailController,
            themeMode: _themeMode,
            saving: _saving,

            onThemeChanged: (value) {
              setState(() {
                _themeMode = value;
              });
            },

            onSave: _saveProfile,

            onLogout: _logout,
          );
        },
      ),
    );
  }
}