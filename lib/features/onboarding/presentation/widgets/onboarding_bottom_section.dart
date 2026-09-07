import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_navigation.dart';

/// A bottom section widget for the onboarding screens.
/// 
/// Displays the onboarding indicator and navigation buttons (Next, Back) at the bottom of the screen.
class OnboardingBottomSection extends StatelessWidget {
  const OnboardingBottomSection({
    super.key, 
    required this.isTablet, 
    required this.currentPage, 
    required this.itemCount, 
    required this.onNext, 
    required this.onBack, 
    required this.isFirstPage, 
    required this.isLastPage});
    
    /// Whether the device is a tablet, used to adjust padding and layout.
    final bool isTablet;

    /// The current page index in the onboarding flow.
    final int currentPage;

    /// The total number of pages in the onboarding flow.
    final int itemCount;

    /// Callback function to be called when the Next button is pressed.
    final VoidCallback onNext;

    /// Callback function to be called when the Back button is pressed.
    final VoidCallback onBack;

    /// Whether the current page is the first page in the onboarding flow.
    final bool isFirstPage;

    /// Whether the current page is the last page in the onboarding flow.
    final bool isLastPage;


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 700,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          isTablet ? 48 : AppSpacing.lg,
          AppSpacing.md,
          isTablet ? 48 : AppSpacing.lg,
          isTablet ? 40 : AppSpacing.lg,
        ),
        child: Column(
          children: [
            OnboardingIndicator(
              currentPage: currentPage,
              itemCount: itemCount,
            ),

            const SizedBox(height: AppSpacing.xl),

            OnboardingNavigation(
              isFirstPage: isFirstPage,
              isLastPage: isLastPage,
              onNext: onNext,
              onBack: onBack,
            ),
          ],
        ),
      ),
    );
  }
}