import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  final bool showShadow;
  final VoidCallback? onTap;
  final Clip? clipBehavior;
  final Border? border;
  final double? width;
  final double? height;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.borderRadius,
    this.showShadow = true,
    this.onTap,
    this.clipBehavior,
    this.border,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget card = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? theme.cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.defaultBorderRadius),
        border: border,
        boxShadow: showShadow ? AppTheme.cardShadow : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.defaultBorderRadius),
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.defaultBorderRadius),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16.0),
              child: child,
            ),
          ),
        ),
      ),
    );

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: card,
      );
    }
    
    return card;
  }
}

class SectionCard extends StatelessWidget {
  final String? title;
  final Widget? titleTrailing;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final bool showShadow;
  final bool showBorder;
  final BorderRadius? borderRadius;

  const SectionCard({
    super.key,
    this.title,
    this.titleTrailing,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.showShadow = true,
    this.showBorder = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: margin,
      color: color,
      showShadow: showShadow,
      borderRadius: borderRadius,
      border: showBorder ? Border.all(color: AppTheme.borderColor) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (titleTrailing != null) titleTrailing!,
              ],
            ),
            const SizedBox(height: 12),
          ],
          Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return CustomCard(
      onTap: onTap,
      color: backgroundColor ?? colorScheme.surface,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (iconColor ?? colorScheme.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor ?? colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
