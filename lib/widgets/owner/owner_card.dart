import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/owner_theme.dart';

class OwnerCard extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? subtitle;
  final Widget? header;
  final Widget? footer;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool withBorder;
  final bool withShadow;
  final VoidCallback? onTap;
  final int animationDelay;

  const OwnerCard({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.header,
    this.footer,
    this.backgroundColor,
    this.padding,
    this.withBorder = true,
    this.withShadow = true,
    this.onTap,
    this.animationDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardDecoration = withBorder
        ? OwnerTheme.cardDecoration.copyWith(
            color: backgroundColor ?? theme.cardColor,
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: withShadow
                ? OwnerTheme.mediumShadow
                : null,
          )
        : null;

    Widget content = Container(
      decoration: cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null) header!,
          if (title != null || subtitle != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: OwnerTheme.heading3,
                    ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        subtitle!,
                        style: OwnerTheme.subtitle2,
                      ),
                    ),
                ],
              ),
            ),
          if (child != null)
            Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child!,
            ),
          if (footer != null) footer!,
        ],
      ),
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: content,
        ),
      );
    }

    return content.animate(delay: (animationDelay * 100).ms).fadeIn(
          duration: 300.ms,
          curve: Curves.easeOutQuart,
        );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isTrendingUp;
  final String? trendText;
  final int animationDelay;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.isTrendingUp = true,
    this.trendText,
    this.animationDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final trendColor = isTrendingUp ? OwnerTheme.successColor : OwnerTheme.errorColor;
    final iconBgColor = backgroundColor ?? (iconColor?.withValues(alpha: 0.1) ?? colorScheme.primary.withValues(alpha: 0.1));
    final iconColorFinal = iconColor ?? colorScheme.primary;
    
    return OwnerCard(
      backgroundColor: theme.cardColor,
      padding: const EdgeInsets.all(16),
      animationDelay: animationDelay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: OwnerTheme.subtitle2.copyWith(
                  color: OwnerTheme.textSecondary,
                ),
              ),
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColorFinal,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                value,
                style: OwnerTheme.heading2.copyWith(
                  color: OwnerTheme.textPrimary,
                ),
              ),
              if (trendText != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: trendColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isTrendingUp ? Icons.trending_up : Icons.trending_down,
                        size: 14,
                        color: trendColor,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        trendText!,
                        style: OwnerTheme.caption.copyWith(
                          color: trendColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: OwnerTheme.caption.copyWith(
                color: OwnerTheme.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;
  final int animationDelay;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color,
    required this.onTap,
    this.animationDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconColor = color ?? colorScheme.primary;
    
    return OwnerCard(
      onTap: onTap,
      animationDelay: animationDelay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: OwnerTheme.subtitle1.copyWith(
              fontWeight: FontWeight.w600,
              color: OwnerTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: OwnerTheme.body2.copyWith(
              color: OwnerTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
