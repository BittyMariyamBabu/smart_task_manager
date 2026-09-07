import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/validators/app_validators.dart';
import 'package:task_manager/features/auth/presentation/pages/register_page.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_bottom.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_button.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_branding.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_heading.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_layout.dart';
import 'package:task_manager/features/auth/presentation/widgets/auth_text_field.dart';

/// A login page for the Smart Task Manager application.
/// 
/// This page provides a form for users to enter their email, password and 
/// confirm password to log in an acount. It includes validation for the input 
/// fields and a loading state for the login button. Users can also navigate 
/// to the registration page if they don't have an account.

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  /// Disposes of the controllers when the widget is removed from the widget tree.
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handles the login action when the user presses the login button.
  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
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
            title: 'Welcome back',
            subtitle: 'Sign in to continue managing your tasks.',
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
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            textInputAction: TextInputAction.done,
            obscureText: _obscurePassword,
            onToggleObscured: () {
              setState(() {
                _obscurePassword =
                    !_obscurePassword;
              });
            },
            validator: AppValidators.validatePassword,
          ),
      
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot password?'),
            ),
          ),
      
          const SizedBox(height: AppSpacing.sm),
      
          AuthButton(
            onPressed: _login,
            label: 'Login',
            isLoading: false,
          ),
      
          const SizedBox(height: AppSpacing.xl),
      
          AuthBottom(
            mainText: "Don't have an account?",
            subText: 'Create account',
            onPressed: () =>
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) =>
                    const RegisterPage(),
                ),
              )
          ),
        ]
      ),
    );
  }
}


