import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_spacing.dart';

/// Provides the common layout used by authentication screens.
///
/// Handles safe-area spacing, keyboard dismissal, scrolling,
/// responsive width constraints, and form positioning.
///
/// Authentication pages such as [LoginPage] and [RegisterPage]
/// can provide their own form content through the [child] parameter
/// while sharing the same overall layout.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.child,
    required this.formKey,
    super.key,
  });

  /// The form key associated with the authentication form.
  final GlobalKey<FormState> formKey;

  /// The authentication form content displayed inside the layout.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 440,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xl,
                    ),
                    child: Form(
                      key: formKey,
                      child: child,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}