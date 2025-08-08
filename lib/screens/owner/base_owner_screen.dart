import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseOwnerScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showBackButton;
  final Color? backgroundColor;

  const BaseOwnerScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.floatingActionButton,
    this.showBackButton = true,
    this.backgroundColor = const Color(0xFFF8FAFC),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1E293B)),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions: actions,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: child.animate().fadeIn(duration: 600.ms).slideY(
                begin: 0.1,
                end: 0,
                curve: Curves.easeOutCubic,
              ),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.backgroundColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final List<Color>? gradientColors;
  final Widget? icon;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = true,
    this.padding,
    this.width,
    this.height,
    this.gradientColors,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final button = Container(
      width: isFullWidth ? double.infinity : width,
      height: height ?? 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors ??
              const [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (gradientColors?.first ?? const Color(0xFF667EEA)).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: padding,
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );

    return button;
  }
}
