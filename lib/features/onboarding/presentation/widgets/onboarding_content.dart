import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/features/onboarding/models/onboarding_model.dart';
import 'onboarding_illustration.dart';

/// A widget that displays the content of an onboarding page, including an illustration, title, and description.
/// 
/// The layout adapts to different screen sizes (tablet vs. mobile) and adjusts the size of the illustration accordingly.
class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    required this.item,
    required this.availableHeight,
    required this.availableWidth,
    super.key,
  });
  
  /// The onboarding model containing the title, description, and illustration type for the current onboarding page.
  final OnboardingModel item;

  /// The available height of the screen, used to determine layout adjustments for smaller screens.
  final double availableHeight;

  /// The available width of the screen, used to determine layout adjustments for tablet vs. mobile screens.
  final double availableWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isSmallHeight = availableHeight < 650;
    final isTablet = availableWidth >= 600;

    final illustrationSize = isTablet
        ? 330.0
        : isSmallHeight
            ? 230.0
            : 280.0;

    final horizontalPadding = isTablet ? 80.0 : 24.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 700,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnboardingIllustrationWidget(
                type: item.illustration,
                size: illustrationSize,
              ),

              SizedBox(
                height: isSmallHeight
                    ? AppSpacing.lg
                    : AppSpacing.xl,
              ),

              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontSize: isTablet ? 32 : null,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 540,
                ),
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.55,
                    fontSize: isTablet ? 17 : null,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}