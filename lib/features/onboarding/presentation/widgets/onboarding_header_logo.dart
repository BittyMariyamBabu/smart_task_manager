import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_spacing.dart';

/// A header widget for the onboarding screens.
/// 
/// Displays the app logo, title, and a skip button. 
/// The layout adapts to different screen sizes (tablet vs. mobile).
class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key, required this.isTablet, required this.onPressed});

  /// Whether the device is a tablet, used to adjust padding and layout.
  final bool isTablet;

  /// Callback function to be called when the skip button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 48 : AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          OnboardingLogo(),

          const SizedBox(width: 10),

          Text(
            'Smart Task Manager',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),

          const Spacer(),

          TextButton(
            onPressed: onPressed,
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}


/// A logo widget for the onboarding screens.
/// 
/// Displays a check icon inside a circular container, representing the app's branding.
class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.check_rounded,
        color: AppColors.white,
        size: 23,
      )
    );
  }
}