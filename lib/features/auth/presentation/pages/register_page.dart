import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/validators/app_validators.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_bottom.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_branding.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_button.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_heading.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_layout.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:task_manager/features/auth/presentation/widgets/terms_checkbox.dart';


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
  bool _isLoading = false;

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
    if (!_acceptedTerms || !(_formKey.currentState?.validate() ?? false)) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

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
                  
          const SizedBox(
            height: AppSpacing.lg,
          ),
                  
          AuthTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
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
            onPressed: _acceptedTerms ? _register : null,
            label: 'Create account',
            isLoading: _isLoading,
          ),
                  
          const SizedBox(height: AppSpacing.xl),
                  
          AuthBottom(
            mainText: 'Already have an account?',
            subText: 'Log in',
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          ),
        ]
      ),
    );
  }
}
