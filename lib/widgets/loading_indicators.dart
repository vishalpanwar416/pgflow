import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final Widget? child;
  final bool isLoading;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
    this.baseColor,
    this.highlightColor,
    this.child,
    this.isLoading = true,
  });

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _gradientPosition = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading && widget.child != null) {
      return widget.child!;
    }

    final baseColor = widget.baseColor ?? AppTheme.surfaceTertiary;
    final highlightColor = widget.highlightColor ?? Colors.white12;

    return AnimatedBuilder(
      animation: _gradientPosition,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(_gradientPosition.value, 0.0),
              end: Alignment(_gradientPosition.value + 1, 0.0),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double spacing;
  final EdgeInsets padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ShimmerList({
    super.key,
    this.itemCount = 4,
    this.itemHeight = 80.0,
    this.spacing = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        return ShimmerLoading(
          width: double.infinity,
          height: itemHeight,
          borderRadius: 12.0,
        );
      },
    );
  }
}

class PulseLoading extends StatefulWidget {
  final double size;
  final Color? color;
  final Duration duration;
  final Curve curve;

  const PulseLoading({
    super.key,
    this.size = 24.0,
    this.color,
    this.duration = const Duration(milliseconds: 1500),
    this.curve = Curves.easeInOut,
  });

  @override
  _PulseLoadingState createState() => _PulseLoadingState();

  static Widget buildPulseLoading({double size = 24.0, Color? color, Duration duration = const Duration(milliseconds: 1500), Curve curve = Curves.easeInOut}) {
    return PulseLoading(
      size: size,
      color: color,
      duration: duration,
      curve: curve,
    );
  }
}

class _PulseLoadingState extends State<PulseLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulseColor = widget.color ?? Theme.of(context).colorScheme.primary;
    
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Opacity(
              opacity: _controller.status == AnimationStatus.reverse ? _controller.value : 1.0,
              child: child,
            ),
          );
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: pulseColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class BouncingDotsLoading extends StatefulWidget {
  final double dotSize;
  final Color? color;
  final Duration duration;
  final int dotCount;
  final double spacing;

  const BouncingDotsLoading({
    super.key,
    this.dotSize = 8.0,
    this.color,
    this.duration = const Duration(milliseconds: 1000),
    this.dotCount = 3,
    this.spacing = 4.0,
  });

  @override
  _BouncingDotsLoadingState createState() => _BouncingDotsLoadingState();
}

class _BouncingDotsLoadingState extends State<BouncingDotsLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    // Create staggered animations for each dot
    for (int i = 0; i < widget.dotCount; i++) {
      final animation = Tween<double>(begin: 0.5, end: 1.2).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (i * 0.2).clamp(0.0, 1.0),
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      );
      _animations.add(animation);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.dotCount, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _animations[index].value,
              child: Container(
                width: widget.dotSize,
                height: widget.dotSize,
                margin: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
class AnimatedProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Duration duration;
  final Curve curve;
  final bool showPercentage;
  final TextStyle? percentageStyle;

  const AnimatedProgressBar({
    super.key,
    required this.value,
    this.height = 8.0,
    this.borderRadius = 4.0,
    this.backgroundColor,
    this.gradient,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.showPercentage = false,
    this.percentageStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final progressGradient = gradient ??
        LinearGradient(
          colors: [
            AppTheme.primaryStart,
            AppTheme.primaryEnd,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: duration,
                    curve: curve,
                    width: constraints.maxWidth * value.clamp(0.0, 1.0),
                    decoration: BoxDecoration(
                      gradient: progressGradient,
                      borderRadius: BorderRadius.circular(borderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryStart.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (showPercentage) ...[
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: duration,
            style: percentageStyle ??
                theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
            child: Text(
              '${(value * 100).toStringAsFixed(0)}%',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ],
    );
  }
}
