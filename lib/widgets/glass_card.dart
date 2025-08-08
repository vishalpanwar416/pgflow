import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool showShadow;
  final bool showBorder;
  final bool animate;
  final Duration animationDelay;
  final double elevation;
  final Color? color;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.onTap,
    this.showShadow = true,
    this.showBorder = true,
    this.animate = true,
    this.animationDelay = Duration.zero,
    this.elevation = 0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppTheme.surfaceSecondary.withValues(alpha: 0.7),
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        border: showBorder
            ? Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              )
            : null,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        elevation: elevation,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(24),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20.0),
            child: child,
          ),
        ),
      ),
    );

    if (!animate) return card;

    return card
        .animate(
          delay: animationDelay,
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          curve: Curves.easeOutCubic,
        )
        .fadeIn(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
  }
}

// Glass Card with gradient border
class GlassCardGradient extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final bool showShadow;
  final bool animate;
  final Duration animationDelay;

  const GlassCardGradient({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.onTap,
    this.gradient,
    this.showShadow = true,
    this.animate = true,
    this.animationDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryStart.withValues(alpha: 0.3),
                AppTheme.primaryEnd.withValues(alpha: 0.3),
              ],
            ),
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceSecondary.withValues(alpha: 0.8),
              borderRadius: borderRadius ?? BorderRadius.circular(24),
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(20.0),
              child: child,
            ),
          ),
        ),
      ),
    );

    if (!animate) return card;

    return card
        .animate(
          delay: animationDelay,
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          curve: Curves.easeOutCubic,
        )
        .fadeIn(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
  }
}
