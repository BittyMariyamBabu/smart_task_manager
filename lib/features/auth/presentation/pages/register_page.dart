import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/validators/app_validators.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_bottom.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_branding.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_button.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_heading.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_layout.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:task_manager/features/auth/presentation/widgets/terms_checkbox.dart';
import 'package:task_manager/widgets/app_snackbar.dart';


/// A registration page for the Smart Task Manager application.
/// 
/// This page provides a form for users to enter their name, email, password and 
/// confirm password to create an account. It includes validation for the input fields 
/// and a loading state for the registration button. Users can also navigate 
/// to the login page if they already have an account.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  @override
  /// Disposes of the controllers when the widget is removed from the widget tree.
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles the registration action when the user presses the registration button.
  Future<void> _register() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (!_acceptedTerms) {
    AppSnackbar.error(
      context,
      'Please accept the Terms & Conditions.',
    );
    return;
  }

    await ref.read(authControllerProvider.notifier).register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the authentication controller state to handle loading and error states.
    ref.listen<AsyncValue<void>>(
      authControllerProvider,
      (previous, next) {
        // Error
        if (next.hasError && !next.isLoading) {
          AppSnackbar.error(
            context,
            next.error.toString(),
          );
          return;
        }
        
        // Success
        if (previous?.isLoading == true && next.hasValue) {
          AppSnackbar.success(
            context,
            'Sign up successful. You can now log in.',
          );
          Navigator.of(context).pop();
        }
      },
    );

    final state = ref.watch(authControllerProvider);

    return AuthLayout(
      formKey: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthBranding(),
                  
          const AuthHeading(
            title: 'Create an account',
            subtitle: 'Sign up to get started with the Smart Task Manager.',
          ),
                  
          AuthTextField(
            controller: _nameController,
            label: 'Name',
            hintText: 'Enter your name',
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: AppValidators.validateName,
          ),
                  
          const SizedBox(height: AppSpacing.lg),
                  
          AuthTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.validateEmail,
          ),
                  
          const SizedBox(height: AppSpacing.lg),
                  
          AuthTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Create a password',
            prefixIcon: Icons.lock_outline,
            textInputAction: TextInputAction.next,
            obscureText: _obscurePassword,
            onToggleObscured: () => setState(
              () => _obscurePassword = !_obscurePassword,
            ),
            validator: AppValidators.validatePassword,
          ),
                  
          const SizedBox(height: AppSpacing.lg),                     
                  
          AuthTextField(
            controller: _confirmPasswordController,
            label: 'Confirm password',
            hintText: 'Re-enter your password',
            prefixIcon: Icons.lock_outline,
            textInputAction: TextInputAction.done,
            obscureText: _obscureConfirmPassword,
            onToggleObscured: () => setState(
              () => _obscureConfirmPassword = !_obscureConfirmPassword,
            ),
            validator: (value) => AppValidators.confirmPassword(
              value,
              _passwordController.text,
            ),
          ),
                  
          const SizedBox(height: AppSpacing.md),
                  
          TermsCheckbox(
            value: _acceptedTerms,
            onChanged: (value) => setState(() {
              _acceptedTerms = value ?? false;
            }),
          ),
                  
          const SizedBox(height: AppSpacing.sm),
                  
          AuthButton(
            onPressed: state.isLoading ? null : _register,
            label: 'Create account',
            isLoading: state.isLoading,
          ),
                  
          const SizedBox(height: AppSpacing.xl),
                  
          AuthBottom(
            mainText: 'Already have an account?',
            subText: 'Log in',
            onPressed: state.isLoading ? null : () => Navigator.of(context).pop(),
          ),
        ]
      ),
    );
  }
}
