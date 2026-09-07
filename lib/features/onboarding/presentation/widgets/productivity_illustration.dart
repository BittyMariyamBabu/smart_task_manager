import 'package:flutter/material.dart';

/// A widget that displays a productivity illustration, typically used in onboarding screens.
/// 
/// The illustration consists of a circular container with a shadow, an icon, 
/// and text indicating that the user is "All caught up!" and has done great work today.
class ProductivityIllustration extends StatelessWidget {
  const ProductivityIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 190,
      height: 190,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IllustrationIconWidget(
            boxRadius: 82, 
            icon: Icons.check_circle_rounded,
            size: 54,
          ),
          const SizedBox(height: 18),
          Text(
            'All caught up!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Great work today',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

/// A widget that displays an icon within a circular container, typically used in onboarding illustrations.
/// 
/// The icon is centered within the container, and the container has a shadow and a border radius.
class IllustrationIconWidget extends StatelessWidget {
  const IllustrationIconWidget({
    super.key, 
    required this.boxRadius, 
    required this.icon, 
    required this.size,
  });

  final double boxRadius;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: boxRadius,
      height: boxRadius,
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.10),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: size,
        color: colors.primary,
      ),
    );
  }
}
