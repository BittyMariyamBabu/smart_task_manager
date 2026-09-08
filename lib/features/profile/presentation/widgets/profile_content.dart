import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/validators/app_validators.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:task_manager/features/profile/presentation/widgets/dark_mode_dropdown.dart';
import 'package:task_manager/features/profile/presentation/widgets/profile_header.dart';
import 'package:task_manager/features/profile/presentation/widgets/section_title.dart';

/// A widget that displays the profile content, including personal 
/// information, appearance settings, and actions for saving changes 
/// and logging out.
class ProfileContent extends StatelessWidget {
  /// A form key used to validate the form.
  final GlobalKey<FormState> formKey;
  
  /// A controller for the name text field.
  final TextEditingController nameController;
  
  /// A controller for the email text field.
  final TextEditingController emailController;

  /// The currently selected theme mode.
  final String themeMode;
  
  /// A flag indicating whether the profile is currently being saved.
  final bool saving;

  /// A callback function that is called when the user changes the theme mode.
  final ValueChanged<String> onThemeChanged;
  
  /// A callback function that is called when the user presses the save button.
  final VoidCallback onSave;


  /// A callback function that is called when the user presses the logout button.
  final VoidCallback onLogout;

  const ProfileContent({
    super.key, 
    required this.formKey, 
    required this.nameController, 
    required this.emailController, 
    required this.themeMode, 
    required this.saving, 
    required this.onThemeChanged,
    required this.onSave, 
    required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Keep the form from becoming excessively wide
        // on tablets and desktop/web.
        final maxWidth =
            constraints.maxWidth > 600
                ? 600.0
                : double.infinity;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              AppSpacing.lg,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    ProfileHeader(
                      name: nameController.text,
                      email: emailController.text,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    const SectionTitle(
                      title: 'Personal Information',
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    // Name
                    AuthTextField(
                      controller: nameController,
                      label: 'Name',
                      hintText: 'Enter your name',
                      prefixIcon:
                          Icons.person_outline,
                      validator:
                          AppValidators.validateName,
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    // Email
                    AuthTextField(
                      controller:emailController,
                      label: 'Email',
                      hintText: emailController.text,
                      prefixIcon:
                          Icons.email_outlined,
                      validator:
                          AppValidators.validateEmail,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),


                    const SectionTitle(
                      title: 'Appearance',
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    DarkModeDropdown(
                      value: themeMode,
                      onChanged: onThemeChanged,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // Save
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed:
                            saving ? null : onSave,
                        child: saving
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Save Changes',
                              ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    // ------------------------------------------------
                    // Logout
                    // ------------------------------------------------

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed:
                            saving ? null : onLogout,
                        icon: const Icon(
                          Icons.logout,
                        ),
                        label:
                            const Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}