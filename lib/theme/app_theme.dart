import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ===== Color Palette - Raw Tokens =====
  // Primary Colors
  static const Color primary100 = Color(0xFFEEF2FF);
  static const Color primary200 = Color(0xFFE0E7FF);
  static const Color primary300 = Color(0xFFC7D2FE);
  static const Color primary400 = Color(0xFF818CF8);
  static const Color primary500 = Color(0xFF6366F1);
  static const Color primary600 = Color(0xFF4F46E5);
  static const Color primary700 = Color(0xFF4338CA);
  static const Color primary800 = Color(0xFF3730A3);
  static const Color primary900 = Color(0xFF312E81);

  // Legacy color names for backward compatibility
  static const Color primaryColor = primary600;
  static const Color primaryLight = primary400;
  static const Color primaryDark = primary700;
  static const Color secondaryColor = success; // Using success color as secondary
  static const Color errorColor = error;
  static const Color warningColor = warning;
  static const Color successColor = success;
  static const Color infoColor = info;
  static const Color primaryStart = primary600;
  static const Color primaryEnd = primary700;
  static const Color surfacePrimary = neutral50;
  static const Color surfaceSecondary = neutral100;
  static const Color surfaceTertiary = neutral200;
  static const Color neonBlue = primary400;
  static const Color accentColor = primary400;

  // Neutral Colors
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  // Legacy neutral colors
  static const Color backgroundColor = neutral50;
  static const Color surfaceColor = Colors.white;
  static const Color onSurfaceHighEmphasis = neutral900;
  static const Color onSurfaceMediumEmphasis = neutral500;
  static const Color onSurfaceDisabled = neutral400;
  static const Color borderColor = neutral200;

  // Gradients - Legacy
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary600, primary700],
  );

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Dark Mode Colors
  static const Color surfaceDark1 = Color(0x0DFFFFFF);
  static const Color surfaceDark2 = Color(0x14FFFFFF);
  static const Color surfaceDark3 = Color(0x1FFFFFFF);
  static const Color neutral100Dark = Color(0xFF1A1A1A);
  static const Color neutral900Dark = Color(0xFFE5E7EB);

  // ===== Spacing System =====
  static const double spacing0 = 0;
  static const double spacing1 = 4.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 20.0;
  static const double spacing6 = 24.0;
  static const double spacing8 = 32.0;
  static const double spacing10 = 40.0;
  static const double spacing12 = 48.0;
  static const double spacing16 = 64.0;
  static const double spacing20 = 80.0;
  static const double spacing24 = 96.0;
  static const double spacing32 = 128.0;
  static const double spacing40 = 160.0;
  static const double spacing48 = 192.0;
  static const double spacing64 = 256.0;

  // ===== Border Radius =====
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2Xl = 24.0;
  static const double radiusFull = 9999.0;
  static const double defaultBorderRadius = radiusMd;

  // ===== Elevation =====
  static const List<BoxShadow> elevation0 = [];
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 1.0,
      offset: Offset(0, 1),
    )
  ];
  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 2.0,
      offset: Offset(0, 1),
    )
  ];
  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 4.0,
      offset: Offset(0, 2),
    )
  ];

  // Card shadows
  static const List<BoxShadow> cardShadow = elevation2;

  // ===== Z-index =====
  static const int zIndexDropdown = 1000;
  static const int zIndexSticky = 1020;
  static const int zIndexFixed = 1030;
  static const int zIndexModalBackdrop = 1040;
  static const int zIndexOffcanvas = 1050;
  static const int zIndexModal = 1060;
  static const int zIndexPopover = 1070;
  static const int zIndexTooltip = 1080;
  static const int zIndexToast = 1090;

  // ===== Animation =====
  static const Duration duration100 = Duration(milliseconds: 100);
  static const Duration duration200 = Duration(milliseconds: 200);
  static const Duration duration300 = Duration(milliseconds: 300);
  static const Duration duration400 = Duration(milliseconds: 400);
  static const Duration duration500 = Duration(milliseconds: 500);

  // Easing functions
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOutBack = Curves.easeOutBack;
  static const Curve easeOutExpo = Curves.easeOutExpo;

  // ===== Typography =====
  static TextTheme get textTheme {
    final baseTextTheme = GoogleFonts.poppinsTextTheme();
    return baseTextTheme.copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      // Add other text styles as needed
    );
  }

  // ===== Component Themes =====
  // Card Theme
  static CardThemeData get cardTheme => CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: neutral200),
        ),
        color: Colors.white,
        margin: EdgeInsets.zero,
      );

  // Dialog Theme
  static DialogThemeData get dialogTheme => DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      );

  // App Bar
  static AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: primary600,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      );

  // Buttons
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        backgroundColor: primary600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: spacing4,
          vertical: spacing2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        elevation: 0,
        textStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );

  static ButtonStyle get secondaryButton => OutlinedButton.styleFrom(
        foregroundColor: primary600,
        side: const BorderSide(color: primary600),
        padding: const EdgeInsets.symmetric(
          horizontal: spacing4,
          vertical: spacing2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        textStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );

  static ButtonStyle get textButton => TextButton.styleFrom(
        foregroundColor: primary600,
        padding: const EdgeInsets.symmetric(
          horizontal: spacing2,
          vertical: spacing1,
        ),
        textStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      );

  // Text Fields
  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacing3,
          vertical: spacing2,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: neutral200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: neutral200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: primary600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        labelStyle: const TextStyle(color: neutral600),
        hintStyle: const TextStyle(color: neutral400),
        errorStyle: const TextStyle(color: error, fontSize: 12),
      );

  // Chips
  static ChipThemeData get chipTheme => ChipThemeData(
        backgroundColor: neutral100,
        disabledColor: neutral200,
        selectedColor: primary100,
        secondarySelectedColor: primary600,
        padding: const EdgeInsets.symmetric(
          horizontal: spacing2,
          vertical: spacing1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
          side: BorderSide.none,
        ),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: neutral900,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: primary600,
          fontWeight: FontWeight.w500,
        ),
      );

  // Bottom Sheet
  static BottomSheetThemeData get bottomSheetTheme => BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: elevation3[0].blurRadius,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
      );

  // SnackBar
  static SnackBarThemeData get snackBarTheme => SnackBarThemeData(
        backgroundColor: neutral800,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: Colors.black, // Changed from Colors.white
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: elevation2[0].blurRadius,
      );

  // Light Theme
  static ThemeData get lightTheme {
    final theme = ThemeData.light();
    
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: primary600,
        primaryContainer: primary700,
        secondary: primary400,
        surface: neutral50,
        error: error,
        onPrimary: Colors.black, // Changed from Colors.white
        onSecondary: Colors.black, // Changed from Colors.white
        onSurface: neutral900,
        onError: Colors.black, // Changed from Colors.white
      ),
      scaffoldBackgroundColor: neutral50,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: neutral200),
        ),
        color: Colors.white,
        margin: EdgeInsets.zero,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      chipTheme: chipTheme,
      bottomSheetTheme: bottomSheetTheme,
      snackBarTheme: snackBarTheme,
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton),
      outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButton),
      textButtonTheme: TextButtonThemeData(style: textButton),
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: primary600,
        foregroundColor: Colors.black, // Changed from Colors.white
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: Colors.black, // Changed from Colors.white
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black), // Changed from Colors.white
      ),
    );
  }


  // Dark Theme
  static ThemeData get darkTheme {
    final theme = ThemeData.dark();
    final lightCardTheme = CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: neutral200),
      ),
      color: Colors.white,
      margin: EdgeInsets.zero,
    );
    
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: primary400,
        primaryContainer: primary600,
        secondary: primary300,
        surface: neutral900,
        error: error,
        onPrimary: neutral900,
        onSecondary: neutral900,
        onSurface: neutral100Dark,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: neutral900,
      cardTheme: lightCardTheme.copyWith(
        color: neutral800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: neutral700),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: neutral800,
        surfaceTintColor: neutral800,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      chipTheme: chipTheme,
      bottomSheetTheme: bottomSheetTheme.copyWith(
        backgroundColor: neutral800,
      ),
      snackBarTheme: snackBarTheme.copyWith(
        backgroundColor: neutral700,
      ),
      inputDecorationTheme: inputDecorationTheme.copyWith(
        fillColor: neutral800,
        hintStyle: const TextStyle(color: neutral400),
        labelStyle: const TextStyle(color: neutral300),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButton.copyWith(
          backgroundColor: WidgetStateProperty.all(primary400),
          foregroundColor: WidgetStateProperty.all(neutral900),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: secondaryButton.copyWith(
          side: WidgetStateProperty.all(
            const BorderSide(color: primary400),
          ),
          foregroundColor: WidgetStateProperty.all(primary400),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: textButton.copyWith(
          foregroundColor: WidgetStateProperty.all(primary400),
        ),
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: neutral800,
        foregroundColor: neutral100Dark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: neutral100Dark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ===== Component Styles =====
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: primary600,
        foregroundColor: Colors.black, // Changed from Colors.white
        padding: const EdgeInsets.symmetric(
          horizontal: spacing4,
          vertical: spacing2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        elevation: 0,
        textStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );

  // Add other component styles as needed
}

// Extension methods for easy access
extension AppThemeExtension on BuildContext {
  // Colors
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  
  // Text Styles
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
  // Add other text style getters as needed
  
  // Spacing
  double get defaultPadding => AppTheme.spacing4;
  double get smallSpacing => AppTheme.spacing2;
  
  // Other theme-related extensions
}
