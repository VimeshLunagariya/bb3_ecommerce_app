// ignore_for_file: use_key_in_widget_constructors, public_member_api_docs

import 'package:flutter/material.dart';

/// Slides its [child] into position upon creation.
class SlideInAnimation extends StatefulWidget {
  const SlideInAnimation({
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.delay = Duration.zero,
    this.offset = Offset.zero,
    this.curve = Curves.fastOutSlowIn,
  });

  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay until the animation starts.
  final Duration delay;

  /// The offset that the child will have before it slides into position.
  final Offset offset;

  final Curve curve;

  @override
  _SlideInAnimationState createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _hidden = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    _animation = CurveTween(curve: widget.curve).animate(_controller);

    Future.delayed(widget.delay).then((_) {
      if (mounted) {
        _controller.forward();
        _hidden = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hidden) {
      return Container();
    } else {
      return Transform.translate(
        offset: Offset(
          (1 - _animation.value) * widget.offset.dx,
          (1 - _animation.value) * widget.offset.dy,
        ),
        child: widget.child,
      );
    }
  }
}

/// Slides and fades its child into position upon creation.
class SlideFadeInAnimation extends StatefulWidget {
  const SlideFadeInAnimation({
    required this.child,
    super.key,
    this.duration = const Duration(seconds: 1),
    this.delay = Duration.zero,
    this.offset = Offset.zero,
    this.curve = Curves.fastOutSlowIn,
  });

  /// The child to animate.
  final Widget? child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay until the animation starts.
  final Duration delay;

  /// The offset that the child will have before it slides into position.
  final Offset offset;

  /// The curve used by the animation.
  final Curve curve;

  @override
  _SlideFadeInAnimationState createState() => _SlideFadeInAnimationState();
}

class _SlideFadeInAnimationState extends State<SlideFadeInAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = CurveTween(curve: widget.curve).animate(_controller);

    Future.delayed(widget.delay).then((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(
              (1 - _animation.value) * widget.offset.dx,
              (1 - _animation.value) * widget.offset.dy,
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Fades out its [child] upon creation.
class FadeOutWidget extends StatefulWidget {
  const FadeOutWidget({
    super.key,
    this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  final Widget? child;
  final Duration duration;

  @override
  FadeOutWidgetState createState() => FadeOutWidgetState();
}

class FadeOutWidgetState extends State<FadeOutWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)..forward();
  }

  @override
  void deactivate() {
    _controller.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeOutWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: 1 - _controller.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// A simple animation that "bounces in" its child.

/// A simple animation that "bounces in" its child.
class BounceInAnimation extends StatefulWidget {
  const BounceInAnimation({
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.onTap,
    this.isBounce = true,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final VoidCallback? onTap;
  final bool isBounce;

  @override
  _BounceInAnimationState createState() => _BounceInAnimationState();
}

class _BounceInAnimationState extends State<BounceInAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    _animation = CurveTween(curve: Curves.elasticOut).animate(_controller);

    Future.delayed(widget.delay).then((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isBounce) {
          _controller = AnimationController(vsync: this, duration: widget.duration)
            ..addListener(() {
              if (mounted) setState(() {});
            });

          _animation = CurveTween(curve: Curves.elasticOut).animate(_controller);

          Future.delayed(widget.delay).then((_) {
            if (mounted) _controller.forward();
          });
        }

        if (widget.onTap == null) {
          () {};
        } else {
          widget.onTap!();
        }
      },
      child: Transform.scale(
        scale: _animation.value,
        child: widget.child,
      ),
    );
  }
}

/// A widget that can be used to "slide away" its child by calling a method.
class SlideAnimation extends StatefulWidget {
  const SlideAnimation({
    required this.child,
    required this.endPosition,
    super.key,
    this.duration = const Duration(milliseconds: 600),
  });

  final Widget child;
  final Offset endPosition;
  final Duration duration;

  @override
  SlideAnimationState createState() => SlideAnimationState();
}

class SlideAnimationState extends State<SlideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: widget.endPosition,
    ).animate(CurveTween(curve: Curves.easeInCubic).animate(_controller));
  }

  Future<void> forward() {
    return _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _animation.value,
      child: widget.child,
    );
  }
}

class BlinkingAnimation extends StatefulWidget {
  const BlinkingAnimation({
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
  });

  final Widget child;
  final Duration duration;
  @override
  _MyBlinkingState createState() => _MyBlinkingState();
}

class _MyBlinkingState extends State<BlinkingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
