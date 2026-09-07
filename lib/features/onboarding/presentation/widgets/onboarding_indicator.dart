import 'package:flutter/material.dart';

/// A bottom section indicatorwidget for the onboarding screens.
/// 
/// Displays the onboarding indicator at the bottom of the screen.
class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    required this.currentPage,
    required this.itemCount,
    super.key,
  });

    /// The current page index in the onboarding flow.
    final int currentPage;

    /// The total number of pages in the onboarding flow.
    final int itemCount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final active = index == currentPage;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: active ? 28 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: active
                  ? colors.primary
                  : colors.onSurfaceVariant.withValues(
                      alpha: 0.20,
                    ),
              borderRadius: BorderRadius.circular(100),
            ),
          );
        },
      ),
    );
  }
}