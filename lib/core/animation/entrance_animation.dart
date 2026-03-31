import 'package:flutter/material.dart';

/// Wraps a child widget with an entrance animation driven by JSON props.
///
/// Supported animation types: `fadeIn`, `slideUp`, `slideLeft`, `scale`.
///
/// ```json
/// { "animation": { "type": "fadeIn", "duration": 500, "delay": 200 } }
/// ```
class EntranceAnimation extends StatefulWidget {
  final Widget child;
  final String type;
  final int durationMs;
  final int delayMs;

  const EntranceAnimation({
    super.key,
    required this.child,
    required this.type,
    this.durationMs = 400,
    this.delayMs = 0,
  });

  factory EntranceAnimation.fromProps(
    Map<String, dynamic> animationProps,
    Widget child,
  ) {
    return EntranceAnimation(
      type: animationProps['type'] as String? ?? 'fadeIn',
      durationMs: (animationProps['duration'] as num?)?.toInt() ?? 400,
      delayMs: (animationProps['delay'] as num?)?.toInt() ?? 0,
      child: child,
    );
  }

  @override
  State<EntranceAnimation> createState() => _EntranceAnimationState();
}

class _EntranceAnimationState extends State<EntranceAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationMs),
    );

    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);

    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);

    _slide = switch (widget.type) {
      'slideUp' => Tween<Offset>(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(curved),
      'slideLeft' => Tween<Offset>(
          begin: const Offset(0.15, 0),
          end: Offset.zero,
        ).animate(curved),
      _ => Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(curved),
    };

    _scale = widget.type == 'scale'
        ? Tween<double>(begin: 0.85, end: 1).animate(curved)
        : Tween<double>(begin: 1, end: 1).animate(curved);

    if (widget.delayMs > 0) {
      Future.delayed(Duration(milliseconds: widget.delayMs), () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          child: widget.child,
        ),
      ),
    );
  }
}
