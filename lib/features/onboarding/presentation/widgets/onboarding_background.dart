import 'package:flutter/material.dart';

/// A background widget for the onboarding screens.
///   
/// Displays a decorative background with glow circles and a dot pattern,
/// providing a visually appealing backdrop for the onboarding content.
class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({
    required this.child,
    super.key,
  });
  
  /// The child widget to be displayed on top of the background.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Positioned(
          top: -120,
          right: -100,
          child: _GlowCircle(
            size: 300,
            color: colors.primary.withValues(alpha: 0.08),
          ),
        ),
        Positioned(
          bottom: -150,
          left: -120,
          child: _GlowCircle(
            size: 320,
            color: colors.primary.withValues(alpha: 0.05),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _DotPatternPainter(
              color: colors.onSurface.withValues(alpha: 0.025),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  const _DotPatternPainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    const spacing = 28.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          1,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotPatternPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}