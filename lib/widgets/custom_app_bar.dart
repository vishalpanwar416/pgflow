import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? leading;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? titleSpacing;
  final bool centerTitle;
  final double toolbarHeight;
  final PreferredSizeWidget? bottom;
  final double? leadingWidth;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.leading,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
    this.titleSpacing,
    this.centerTitle = true,
    this.toolbarHeight = kToolbarHeight,
    this.bottom,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? Colors.black, // Changed from Colors.white
        ),
      ),
      leading: leading ?? (showBackButton ? const BackButton() : null),
      actions: actions,
      elevation: elevation,
      backgroundColor: backgroundColor ?? AppTheme.primaryColor,
      foregroundColor: foregroundColor ?? Colors.black, // Changed from Colors.white
      titleSpacing: titleSpacing,
      centerTitle: centerTitle,
      toolbarHeight: toolbarHeight,
      bottom: bottom,
      leadingWidth: leadingWidth,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );
}
