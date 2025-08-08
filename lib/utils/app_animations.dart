import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppAnimations {
  // Fade in animation
  static Animate fadeIn(Widget child, {Duration? duration}) {
    return child.animate().fadeIn(
      duration: duration ?? const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  // Slide in from bottom
  static Animate slideInFromBottom(Widget child, {Duration? duration}) {
    return child.animate().slideY(
      begin: 0.3,
      end: 0,
      duration: duration ?? const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    ).fadeIn(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
    );
  }

  // Staggered list item animation
  static Animate staggeredItem(int index) {
    return Animate(
      delay: Duration(milliseconds: 100 * (index + 1)),
    ).custom(
      begin: 0.0,
      end: 1.0,
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * 20),
          child: child,
        ),
      ),
    );
  }

  // Button press animation
  static Animate buttonPressAnimation(Widget child) {
    return Animate(
      effects: [
        ScaleEffect(
          duration: const Duration(milliseconds: 100),
          begin: const Offset(1, 1),
          end: const Offset(0.95, 0.95),
          curve: Curves.easeInOut,
        ),
      ],
      onPlay: (controller) => controller.repeat(reverse: true),
      child: child,
    );
  }

  // Shimmer effect for loading
  static Animate shimmer(Widget child) {
    return child.animate(
      onPlay: (controller) => controller.repeat(),
    ).shimmer(
      duration: const Duration(milliseconds: 1500),
      size: 0.9,
      angle: 0.3,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }

  // Pulsing animation for important elements
  static Animate pulse(Widget child, {Duration? duration}) {
    return child.animate(
      onPlay: (controller) => controller.repeat(),
    ).scale(
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.05, 1.05),
      duration: duration ?? const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    ).then(delay: const Duration(milliseconds: 100)).scale(
      begin: const Offset(1.05, 1.05),
      end: const Offset(1.0, 1.0),
      duration: duration ?? const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  // Bounce animation for success/error states
  static Animate bounce(Widget child) {
    return child.animate()
      ..scale(
        begin: const Offset(0.8, 0.8),
        end: const Offset(1.0, 1.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticOut,
      )
      ..fadeIn(duration: const Duration(milliseconds: 400));
  }

  // Page transition animation
  static PageRouteBuilder<T> pageRoute<T>({
    required Widget page,
    RouteSettings? settings,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      fullscreenDialog: fullscreenDialog,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  // Staggered grid animation
  static Animate staggeredGridItem(int index) {
    return Animate(
      delay: Duration(milliseconds: 150 * (index % 3)),
    ).custom(
      begin: 0.0,
      end: 1.0,
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, (1 - value) * 50),
        child: Opacity(
          opacity: value,
          child: child,
        ),
      ),
    );
  }

  // Rotate animation for refresh indicators
  static Animate rotate(Widget child) {
    return child.animate(
      onPlay: (controller) => controller.repeat(),
    ).rotate(
      duration: const Duration(milliseconds: 1000),
      begin: 0,
      end: 1,
      curve: Curves.linear,
    );
  }

  // Bouncing animation for notifications
  static Animate bounceIn(Widget child, {Duration? delay}) {
    return child.animate(
      delay: delay,
    )
      ..scale(
        begin: const Offset(0.7, 0.7),
        end: const Offset(1.0, 1.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticOut,
      )
      ..fadeIn(duration: const Duration(milliseconds: 400));
  }

  // Fade out and scale down animation
  static Animate fadeOutAndScale(Widget child) {
    return child.animate()
      ..fadeOut(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
      ..scale(
        begin: const Offset(1.0, 1.0),
        end: const Offset(0.9, 0.9),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
  }

  // Hero-like shared element transition
  static Animate sharedAxisTransition(Widget child, {Axis axis = Axis.horizontal}) {
    return child.animate()
      ..fadeIn(duration: const Duration(milliseconds: 300))
      ..slide(
        begin: axis == Axis.horizontal ? const Offset(0.2, 0) : const Offset(0, 0.2),
        end: Offset.zero,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
  }

  // Shake animation for error states
  static Animate shake(Widget child) {
    return Animate(
      effects: [
        ShakeEffect(
          hz: 4,
          offset: const Offset(10.0, 0.0),
          rotation: 0.1,
          duration: const Duration(milliseconds: 400),
        ),
      ],
      child: child,
    );
  }
}
