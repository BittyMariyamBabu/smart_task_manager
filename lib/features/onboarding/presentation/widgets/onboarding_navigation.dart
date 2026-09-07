import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_radius.dart';
import 'package:task_manager/core/theme/app_spacing.dart';

/// A widget that provides navigation controls for onboarding screens.
///   
/// Displays "Back" and "Next" buttons, allowing users to navigate through the onboarding pages.
class OnboardingNavigation extends StatelessWidget {
  const OnboardingNavigation({
    required this.isFirstPage,
    required this.isLastPage,
    required this.onNext,
    required this.onBack,
    super.key,
  });
  
  /// A boolean indicating whether the current page is the first onboarding page.
  final bool isFirstPage;

  /// A boolean indicating whether the current page is the last onboarding page.
  final bool isLastPage;

  /// A callback function that is called when the "Next" button is pressed.
  final VoidCallback onNext;

  /// A callback function that is called when the "Back" button is pressed.
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    /// A boolean indicating whether the screen width is wide enough to adjust the button sizes.
    final isWide = MediaQuery.sizeOf(context).width >= 600;

    return Row(
      children: [
        SizedBox(
          width: isWide ? 100 : 80,
          child: isFirstPage
              ? const SizedBox.shrink()
              : TextButton.icon(
                  onPressed: onBack,
                  label: const Text('Back'),
                ),
        ),

        const Spacer(),

        SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: onNext,
            style: FilledButton.styleFrom(
              minimumSize: Size(
                isWide ? 170 : 130,
                52,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isLastPage ? 'Get Started' : 'Next',
                ),
                if (!isLastPage) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}