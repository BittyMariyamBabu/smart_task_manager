import 'package:flutter/material.dart';
import 'package:task_manager/features/onboarding/models/onboarding_model.dart';
import 'package:task_manager/features/onboarding/presentation/widgets/deadline_illustration.dart';
import 'package:task_manager/features/onboarding/presentation/widgets/organize_illustration.dart';
import 'package:task_manager/features/onboarding/presentation/widgets/productivity_illustration.dart';

/// A widget that displays an illustration based on the provided OnboardingIllustration type.
/// 
/// The illustration is displayed within a circular container with a shadow and border, 
/// and the size of the illustration can be customized.
class OnboardingIllustrationWidget extends StatelessWidget {
  const OnboardingIllustrationWidget({
    required this.type,
    required this.size,
    super.key,
  });

  /// The type of illustration to display, which determines the content of the illustration.
  final OnboardingIllustration type;

  /// The size of the illustration container, which affects the overall dimensions of the illustration.
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.primary.withValues(alpha: 0.06),
            ),
          ),

          Container(
            width: size * 0.78,
            height: size * 0.78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.primary.withValues(alpha: 0.07),
              border: Border.all(
                color: colors.primary.withValues(alpha: 0.12),
              ),
            ),
          ),

          _buildIllustration(context),
        ],
      ),
    );
  }
  
  /// A private method that builds the appropriate illustration widget 
  /// based on the provided OnboardingIllustration type.
  Widget _buildIllustration(BuildContext context) {
    switch (type) {
      case OnboardingIllustration.organize:
        return OrganizeIllustration();

      case OnboardingIllustration.deadlines:
        return DeadlineIllustration();

      case OnboardingIllustration.productivity:
        return ProductivityIllustration();
    }
  }
}
