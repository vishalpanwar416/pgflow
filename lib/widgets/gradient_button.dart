import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final bool isLoading;
  final Widget? loadingWidget;
  final bool disabled;
  final bool fullWidth;
  final Duration animationDuration;
  final double scaleWhenPressed;
  final List<BoxShadow>? shadow;
  final Widget? icon;
  final double iconSpacing;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradient,
    this.width,
    this.height = 56.0,
    this.borderRadius = 12.0,
    this.padding,
    this.textStyle,
    this.isLoading = false,
    this.loadingWidget,
    this.disabled = false,
    this.fullWidth = false,
    this.animationDuration = Duration.zero,
    this.scaleWhenPressed = 0.98,
    this.shadow,
    this.icon,
    this.iconSpacing = 8.0,
  });

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isTapped = false;
  final Duration _animationDuration = const Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradient = widget.gradient ??
        LinearGradient(
          colors: [
            AppTheme.primaryStart,
            AppTheme.primaryEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    final textStyle = widget.textStyle ??
        theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );

    final buttonChild = widget.isLoading
        ? widget.loadingWidget ??
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) widget.icon!,
              if (widget.icon != null) SizedBox(width: widget.iconSpacing),
              Text(
                widget.text,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ],
          );

    return AnimatedScale(
      scale: _isTapped ? widget.scaleWhenPressed : 1.0,
      duration: _animationDuration,
      child: MouseRegion(
        cursor: widget.disabled || widget.isLoading
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        onEnter: (_) {
          if (!widget.disabled && !widget.isLoading) {
            setState(() => _isTapped = true);
          }
        },
        onExit: (_) {
          if (!widget.disabled && !widget.isLoading) {
            setState(() => _isTapped = false);
          }
        },
        child: GestureDetector(
          onTapDown: (_) {
            if (!widget.disabled && !widget.isLoading) {
              setState(() => _isTapped = true);
            }
          },
          onTapUp: (_) {
            if (!widget.disabled && !widget.isLoading) {
              setState(() => _isTapped = false);
              widget.onPressed();
            }
          },
          onTapCancel: () {
            if (!widget.disabled && !widget.isLoading) {
              setState(() => _isTapped = false);
            }
          },
          child: AnimatedContainer(
            duration: _animationDuration,
            width: widget.fullWidth ? double.infinity : widget.width,
            height: widget.height,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              gradient: widget.disabled
                  ? LinearGradient(
                      colors: [
                        Colors.grey[600]!,
                        Colors.grey[700]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : gradient,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: widget.shadow ??
                  [
                    BoxShadow(
                      color: AppTheme.primaryStart.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
            ),
            child: AnimatedSwitcher(
              duration: _animationDuration,
              child: Center(child: buttonChild),
            ),
          ),
        ),
      ),
    );
  }
}

// Glass Button with gradient border
class GlassGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool disabled;
  final double borderWidth;
  final Duration animationDuration;
  final double scaleWhenPressed;
  final Widget? icon;
  final double iconSpacing;

  const GlassGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradient,
    this.width,
    this.height = 48.0,
    this.borderRadius = 24.0,
    this.padding,
    this.textStyle,
    this.isLoading = false,
    this.disabled = false,
    this.borderWidth = 1.5,
    this.animationDuration = const Duration(milliseconds: 200),
    this.scaleWhenPressed = 0.96,
    this.icon,
    this.iconSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradient = this.gradient ??
        LinearGradient(
          colors: [
            AppTheme.primaryStart,
            AppTheme.primaryEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    final textStyle = this.textStyle ??
        theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: disabled || isLoading ? 1.0 : scaleWhenPressed),
      duration: animationDuration,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: disabled ? 0.6 : 1.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: gradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryStart.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                child: InkWell(
                  onTap: disabled || isLoading ? null : onPressed,
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Container(
                    padding: padding ??
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius - 0.5),
                      color: AppTheme.surfaceSecondary.withValues(alpha: 0.8),
                      border: Border.all(
                        width: borderWidth,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        else if (icon != null) ...[
                          icon!,
                          SizedBox(width: iconSpacing),
                        ],
                        Text(
                          text,
                          style: textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GradientButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool disabled;
  final double borderWidth;
  final Duration animationDuration;
  final double scaleWhenPressed;
  final Widget? icon;
  final double iconSpacing;

  const GradientButtonOutlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradient,
    this.width,
    this.height = 48.0,
    this.borderRadius = 24.0,
    this.padding,
    this.textStyle,
    this.isLoading = false,
    this.disabled = false,
    this.borderWidth = 1.5,
    this.animationDuration = Duration.zero,
    this.scaleWhenPressed = 0.96,
    this.icon,
    this.iconSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradient = this.gradient ??
        LinearGradient(
          colors: [
            AppTheme.primaryStart,
            AppTheme.primaryEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    final textStyle = this.textStyle ??
        theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: disabled || isLoading ? 1.0 : scaleWhenPressed),
      duration: animationDuration,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: disabled ? 0.6 : 1.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: gradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryStart.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                child: InkWell(
                  onTap: disabled || isLoading ? null : onPressed,
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Container(
                    padding: padding ??
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius - 0.5),
                      color: AppTheme.surfaceSecondary.withValues(alpha: 0.8),
                      border: Border.all(
                        width: borderWidth,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        else if (icon != null) ...[
                          icon!,
                          SizedBox(width: iconSpacing),
                        ],
                        Text(
                          text,
                          style: textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
