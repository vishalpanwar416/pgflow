import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum ButtonVariant { 
  primary, 
  secondary, 
  outline, 
  text, 
  danger,
  success
}

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool showShadow;
  final double? elevation;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isRounded;
  final bool isDense;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.showShadow = false,
    this.elevation,
    this.prefixIcon,
    this.suffixIcon,
    this.isRounded = false,
    this.isDense = false,
  });

  // Factory constructor for primary button
  factory CustomButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    bool isLoading = false,
    bool isFullWidth = true,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    Color? backgroundColor,
    Color? textColor,
    bool showShadow = false,
    double? elevation,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isRounded = false,
    bool isDense = false,
  }) {
    return CustomButton(
      key: key,
      onPressed: onPressed,
      child: child,
      variant: ButtonVariant.primary,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      textColor: textColor,
      showShadow: showShadow,
      elevation: elevation,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isRounded: isRounded,
      isDense: isDense,
    );
  }

  // Factory constructor for text button
  factory CustomButton.text({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    bool isLoading = false,
    Color? textColor,
    Color? backgroundColor,
    double? height,
    EdgeInsetsGeometry? padding,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isDense = true,
  }) {
    return CustomButton(
      key: key,
      onPressed: onPressed,
      child: child,
      variant: ButtonVariant.text,
      isLoading: isLoading,
      isFullWidth: false,
      height: height,
      padding: padding,
      backgroundColor: backgroundColor,
      textColor: textColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isDense: isDense,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Determine colors based on variant
    Color? btnBackgroundColor;
    Color? btnTextColor;
    Color? btnBorderColor;
    double? btnElevation = elevation;
    EdgeInsetsGeometry? btnPadding = padding;
    double? btnHeight = height;
    double btnBorderRadius = borderRadius ?? (isRounded ? 100 : AppTheme.defaultBorderRadius);

    switch (variant) {
      case ButtonVariant.primary:
        btnBackgroundColor = backgroundColor ?? colorScheme.primary;
        btnTextColor = textColor ?? colorScheme.onPrimary;
        btnBorderColor = backgroundColor ?? colorScheme.primary;
        btnElevation ??= showShadow ? 2 : 0;
        btnHeight ??= isDense ? 36 : 48;
        btnPadding ??= EdgeInsets.symmetric(
          horizontal: isDense ? 16 : 24,
          vertical: isDense ? 8 : 12,
        );
        break;
        
      case ButtonVariant.secondary:
        btnBackgroundColor = backgroundColor ?? colorScheme.surfaceContainerHighest;
        btnTextColor = textColor ?? colorScheme.onSurfaceVariant;
        btnBorderColor = borderColor ?? colorScheme.outline.withValues(alpha: 0.5);
        btnElevation ??= 0;
        btnHeight ??= isDense ? 36 : 44;
        btnPadding ??= EdgeInsets.symmetric(
          horizontal: isDense ? 12 : 20,
          vertical: isDense ? 6 : 10,
        );
        break;
        
      case ButtonVariant.outline:
        btnBackgroundColor = Colors.transparent;
        btnTextColor = textColor ?? colorScheme.primary;
        btnBorderColor = borderColor ?? colorScheme.primary;
        btnElevation = 0;
        btnHeight ??= isDense ? 36 : 44;
        btnPadding ??= EdgeInsets.symmetric(
          horizontal: isDense ? 12 : 20,
          vertical: isDense ? 6 : 10,
        );
        break;
        
      case ButtonVariant.text:
        btnBackgroundColor = Colors.transparent;
        btnTextColor = textColor ?? colorScheme.primary;
        btnBorderColor = Colors.transparent;
        btnElevation = 0;
        btnHeight ??= isDense ? 32 : 40;
        btnPadding ??= const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
        break;
        
      case ButtonVariant.danger:
        btnBackgroundColor = AppTheme.errorColor;
        btnTextColor = Colors.black; // Changed from Colors.white
        btnBorderColor = AppTheme.errorColor;
        btnElevation ??= showShadow ? 2 : 0;
        btnHeight ??= isDense ? 36 : 44;
        btnPadding ??= EdgeInsets.symmetric(
          horizontal: isDense ? 16 : 20,
          vertical: isDense ? 8 : 10,
        );
        break;
        
      case ButtonVariant.success:
        btnBackgroundColor = AppTheme.successColor;
        btnTextColor = Colors.black; // Changed from Colors.white
        btnBorderColor = AppTheme.successColor;
        btnElevation ??= showShadow ? 2 : 0;
        btnHeight ??= isDense ? 36 : 44;
        btnPadding ??= EdgeInsets.symmetric(
          horizontal: isDense ? 16 : 20,
          vertical: isDense ? 8 : 10,
        );
        break;
    }

    final buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (prefixIcon != null) ...<Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: prefixIcon,
          ),
        ],
        child,
        if (suffixIcon != null) ...<Widget>[
          const SizedBox(width: 8),
          suffixIcon!,
        ],
      ],
    );

    final button = Material(
      color: btnBackgroundColor,
      borderRadius: BorderRadius.circular(btnBorderRadius),
      elevation: btnElevation,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(btnBorderRadius),
        child: Container(
          padding: btnPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(btnBorderRadius),
            border: btnBorderColor != Colors.transparent
                ? Border.all(
                    color: onPressed != null 
                        ? btnBorderColor 
                        : btnBorderColor.withValues(alpha: 0.5),
                    width: 1.0,
                  )
                : null,
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        btnTextColor,
                      ),
                    ),
                  )
                : buttonContent,
          ),
        ),
      ),
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: btnHeight,
      child: button,
    );
  }
}