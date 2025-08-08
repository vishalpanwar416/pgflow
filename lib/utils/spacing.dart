import 'package:flutter/material.dart';

class Spacing {
  // Spacing constants (in logical pixels)
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Standard padding
  static const EdgeInsets allXXSmall = EdgeInsets.all(xxs);
  static const EdgeInsets allXSmall = EdgeInsets.all(xs);
  static const EdgeInsets allSmall = EdgeInsets.all(sm);
  static const EdgeInsets allMedium = EdgeInsets.all(md);
  static const EdgeInsets allLarge = EdgeInsets.all(lg);
  static const EdgeInsets allXLarge = EdgeInsets.all(xl);

  // Horizontal padding
  static const EdgeInsets horizontalXSmall = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSmall = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMedium = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLarge = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXLarge = EdgeInsets.symmetric(horizontal: xl);

  // Vertical padding
  static const EdgeInsets verticalXSmall = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSmall = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMedium = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLarge = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXLarge = EdgeInsets.symmetric(vertical: xl);

  // Custom padding
  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  // Standard gap widgets
  static Widget get gapXXS => const SizedBox(height: xxs, width: xxs);
  static Widget get gapXS => const SizedBox(height: xs, width: xs);
  static Widget get gapSM => const SizedBox(height: sm, width: sm);
  static Widget get gapMD => const SizedBox(height: md, width: md);
  static Widget get gapLG => const SizedBox(height: lg, width: lg);
  static Widget get gapXL => const SizedBox(height: xl, width: xl);
  static Widget get gapXXL => const SizedBox(height: xxl, width: xxl);
  static Widget get gapXXXL => const SizedBox(height: xxxl, width: xxxl);

  // Custom gap widgets
  static Widget gap(double size) => SizedBox(height: size, width: size);
  static Widget hGap(double width) => SizedBox(width: width);
  static Widget vGap(double height) => SizedBox(height: height);
  static Widget get expanded => const Expanded(child: SizedBox.shrink());
  static Widget get expandedFlex => const Expanded(child: SizedBox.shrink());
  static Widget get flexible => const Flexible(child: SizedBox.shrink());
  static Widget get spacer => const Spacer();
}

// Extension methods for adding padding to widgets
extension PaddingExtension on Widget {
  // All sides padding
  Widget padAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  // Horizontal padding
  Widget padHorizontal(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  // Vertical padding
  Widget padVertical(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );

  // Only left padding
  Widget padLeft(double padding) => Padding(
        padding: EdgeInsets.only(left: padding),
        child: this,
      );

  // Only top padding
  Widget padTop(double padding) => Padding(
        padding: EdgeInsets.only(top: padding),
        child: this,
      );

  // Only right padding
  Widget padRight(double padding) => Padding(
        padding: EdgeInsets.only(right: padding),
        child: this,
      );

  // Only bottom padding
  Widget padBottom(double padding) => Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: this,
      );

  // Symmetric padding
  Widget padSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  // Custom padding
  Widget padOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }
}

// Extension for adding margin to widgets
extension MarginExtension on Widget {
  // All sides margin
  Widget marginAll(double margin) => Container(
        margin: EdgeInsets.all(margin),
        child: this,
      );

  // Horizontal margin
  Widget marginHorizontal(double margin) => Container(
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: this,
      );

  // Vertical margin
  Widget marginVertical(double margin) => Container(
        margin: EdgeInsets.symmetric(vertical: margin),
        child: this,
      );

  // Only left margin
  Widget marginLeft(double margin) => Container(
        margin: EdgeInsets.only(left: margin),
        child: this,
      );

  // Only top margin
  Widget marginTop(double margin) => Container(
        margin: EdgeInsets.only(top: margin),
        child: this,
      );

  // Only right margin
  Widget marginRight(double margin) => Container(
        margin: EdgeInsets.only(right: margin),
        child: this,
      );

  // Only bottom margin
  Widget marginBottom(double margin) => Container(
        margin: EdgeInsets.only(bottom: margin),
        child: this,
      );

  // Symmetric margin
  Widget marginSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  // Custom margin
  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }
}
