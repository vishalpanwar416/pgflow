import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A centralized theme class for the PG Flow owner app.
/// Contains all colors, text styles, and other theme-related constants.
class OwnerTheme {
  // Colors
  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color secondaryColor = Color(0xFF818CF8);
  static const Color accentColor = Color(0xFFF59E0B);
  static const Color backgroundColor = Color(0xFFF9FAFB);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color infoColor = Color(0xFF3B82F6);
  
  // Text Colors - Already using black, no changes needed
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.black87;
  static const Color textTertiary = Colors.black54;
  
  // Gradients
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient accentGradient = LinearGradient(
    colors: [warningColor, Color(0xFFFF7E33)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Text Styles - Define each style only once
  static final TextStyle _textStyleHeading1 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    height: 1.2,
  );
  
  static final TextStyle _textStyleHeading2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );
  
  static final TextStyle _textStyleHeading3 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );
  
  static final TextStyle _textStyleSubtitle1 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    height: 1.5,
  );
  
  static final TextStyle _textStyleSubtitle2 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    height: 1.5,
  );
  
  static final TextStyle _textStyleBody1 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
    height: 1.5,
  );
  
  static final TextStyle _textStyleBody2 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondary,
    height: 1.5,
  );
  
  static final TextStyle _textStyleButton = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black, // Changed from Colors.white
    letterSpacing: 0.5,
  );
  
  static final TextStyle _textStyleCaption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textTertiary,
    height: 1.4,
  );
  
  // Public getters for text styles (single source of truth)
  static TextStyle get textStyleHeading1 => _textStyleHeading1;
  static TextStyle get textStyleHeading2 => _textStyleHeading2;
  static TextStyle get textStyleHeading3 => _textStyleHeading3;
  static TextStyle get textStyleSubtitle1 => _textStyleSubtitle1;
  static TextStyle get textStyleSubtitle2 => _textStyleSubtitle2;
  static TextStyle get textStyleBody1 => _textStyleBody1;
  static TextStyle get textStyleBody2 => _textStyleBody2;
  static TextStyle get textStyleButton => _textStyleButton;
  static TextStyle get textStyleCaption => _textStyleCaption;
  
  // Aliases for backward compatibility
  static TextStyle get heading1 => _textStyleHeading1;
  static TextStyle get heading2 => _textStyleHeading2;
  static TextStyle get heading3 => _textStyleHeading3;
  static TextStyle get subtitle1 => _textStyleSubtitle1;
  static TextStyle get subtitle2 => _textStyleSubtitle2;
  static TextStyle get body1 => _textStyleBody1;
  static TextStyle get body2 => _textStyleBody2;
  static TextStyle get button => _textStyleButton;
  static TextStyle get caption => _textStyleCaption;
  
  // Card Styles
  static BoxDecoration cardDecoration = BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );
  
  static BoxDecoration glassCardDecoration = BoxDecoration(
    color: surfaceColor.withValues(alpha: 0.7),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );
  
  // Additional Colors
  static const Color colorInputBackground = Color(0xFFF3F4F6);
  static const Color colorSurfaceVariant = Color(0xFFE5E7EB);
  static const Color colorOnPrimary = Colors.white;
  static const Color colorOnSurfaceVariant = Color(0xFF4B5563);
  
  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: Colors.black, // Changed from Colors.white
        onSurface: textPrimary,
        onError: Colors.black, // Changed from Colors.white
      ),
      textTheme: TextTheme(
        displayLarge: _textStyleHeading1,
        displayMedium: _textStyleHeading2,
        displaySmall: _textStyleHeading3,
        titleLarge: _textStyleSubtitle1,
        titleMedium: _textStyleSubtitle2,
        bodyLarge: _textStyleBody1,
        bodyMedium: _textStyleBody2,
        labelLarge: _textStyleButton,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black, // Changed from Colors.white
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black, // Changed from Colors.white
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorInputBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: textStyleBody1.copyWith(color: textSecondary),
        hintStyle: textStyleBody1.copyWith(color: textTertiary),
      ),
    );
  }
  
  // Input Decoration
  static InputDecoration inputDecoration({
    String? hintText, 
    bool isDense = true, 
    String? labelText, 
    Widget? prefixIcon, 
    Widget? suffixIcon,
    Color? fillColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      isDense: isDense,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor ?? colorInputBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: primaryColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide.none,
      ),
      labelStyle: _textStyleBody1.copyWith(color: textSecondary),
      hintStyle: _textStyleBody1.copyWith(color: textTertiary),
    );
  }
  
  // Theme constants
  static const double defaultRadius = 12.0;
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const EdgeInsets paddingLarge = EdgeInsets.all(16.0);
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Convenience getters for theme properties
  static TextTheme get textTheme => lightTheme.textTheme;
  static ColorScheme get colorScheme => lightTheme.colorScheme;
  
  // Button Styles
  static final buttonStylePrimary = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.black, // Changed from Colors.white
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
    elevation: 0,
  );
  
  static final buttonStyleOutline = OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    side: BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
  );
  
  // Shadows
  static List<BoxShadow> get subtleShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get mediumShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get strongShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 30,
      offset: const Offset(0, 8),
    ),
  ];
  
  // Color aliases for backward compatibility
  static Color get colorSurface => surfaceColor;
  static Color get colorPrimary => primaryColor;
  
  // Animation duration getter for backward compatibility
  static Duration get animationDurationMedium => mediumAnimationDuration;
}
