library icons_animate;

import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimateIcons extends StatefulWidget {
  const AnimateIcons({
    Key? key,

    /// The IconData that will be visible before animation Starts
    required this.startIcon,

    /// The IconData that will be visible after animation ends
    required this.endIcon,

    /// The callback on startIcon Press
    /// It should return a bool
    /// If true is returned it'll animate to the end icon
    /// if false is returned it'll not animate to the end icons
    required this.onStartIconPress,

    /// The callback on endIcon Press
    /// /// It should return a bool
    /// If true is returned it'll animate to the end icon
    /// if false is returned it'll not animate to the end icons
    required this.onEndIconPress,

    /// The size of the icon that are to be shown.
    this.size,

    /// AnimateIcons controller
    required this.controller,

    /// The color to be used for the [startIcon]
    this.startIconColor,

    // The color to be used for the [endIcon]
    this.endIconColor,

    /// The duration for which the animation runs
    this.duration = const Duration(milliseconds: 1000),

    /// The curve for the animation
    /// Default is Curves.easeInOut
    this.curve = Curves.easeInOut,

    /// If the animation runs in the clockwise or anticlockwise direction
    this.clockwise = true,

    /// This is the tooltip that will be used for the [startIcon]
    this.startTooltip,

    /// This is the tooltip that will be used for the [endIcon]
    this.endTooltip,
  }) : super(key: key);

  final IconData startIcon, endIcon;
  final bool Function() onStartIconPress, onEndIconPress;
  final Duration duration;
  final Curve curve;
  final bool clockwise;
  final double? size;
  final Color? startIconColor, endIconColor;
  final AnimateIconController controller;
  final String? startTooltip, endTooltip;

  @override
  _AnimateIconsState createState() => _AnimateIconsState();
}

class _AnimateIconsState extends State<AnimateIcons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.clockwise ? widget.curve : widget.curve.flipped,
      ),
    );
    initControllerFunctions();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  initControllerFunctions() {
    widget.controller.animateToEnd = () {
      if (mounted) {
        _controller.forward();
        return true;
      } else {
        return false;
      }
    };
    widget.controller.animateToStart = () {
      if (mounted) {
        _controller.reverse();
        return true;
      } else {
        return false;
      }
    };
    widget.controller.isStart = () => _animation.value == 0.0;
    widget.controller.isEnd = () => _animation.value == 1.0;
  }

  _onStartIconPress() {
    if (widget.onStartIconPress() && mounted) _controller.forward();
  }

  _onEndIconPress() {
    if (widget.onEndIconPress() && mounted) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    double x = _animation.value;
    double y = 1.0 - _animation.value;
    double opacityX = x >= 0 && x <= 1.0 ? x : _controller.value;
    double opacityY = y >= 0 && y <= 1.0 ? y : (1 - _controller.value);
    double angleX = math.pi / 180 * (180 * x);
    double angleY = math.pi / 180 * (180 * y);

    Widget first() {
      final icon = Icon(widget.startIcon, size: widget.size);
      return Transform.rotate(
        angle: widget.clockwise ? angleX : -angleX,
        child: Opacity(
          opacity: opacityY,
          child: IconButton(
            iconSize: widget.size ?? 24.0,
            color: widget.startIconColor ?? Theme.of(context).primaryColor,
            disabledColor: Colors.grey.shade500,
            icon: widget.startTooltip == null
                ? icon
                : Tooltip(
                    message: widget.startTooltip!,
                    child: icon,
                  ),
            onPressed: _onStartIconPress,
          ),
        ),
      );
    }

    Widget second() {
      final icon = Icon(widget.endIcon);
      return Transform.rotate(
        angle: widget.clockwise ? -angleY : angleY,
        child: Opacity(
          opacity: opacityX,
          child: IconButton(
            iconSize: widget.size ?? 24.0,
            color: widget.endIconColor ?? Theme.of(context).primaryColor,
            disabledColor: Colors.grey.shade500,
            icon: widget.endTooltip == null
                ? icon
                : Tooltip(
                    message: widget.endTooltip!,
                    child: icon,
                  ),
            onPressed: _onEndIconPress,
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        x == 1 && y == 0 ? second() : first(),
        x == 0 && y == 1 ? first() : second(),
      ],
    );
  }
}

class AnimateIconController {
  late bool Function() animateToStart, animateToEnd;
  late bool Function() isStart, isEnd;
}