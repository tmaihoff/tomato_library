import 'package:flutter/widgets.dart';

class SwipeDetector extends StatefulWidget {
  const SwipeDetector({
    super.key,
    required this.child,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.minimumSwipeDistance = 10,
  });

  final Widget child;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final double minimumSwipeDistance;

  @override
  State<SwipeDetector> createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  bool swipeHandled = false;
  int numberOfTouches = 0;
  Offset initialPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => numberOfTouches++,
      onPanDown: (details) {
        swipeHandled = false;
        initialPosition = details.globalPosition;
      },
      onTapUp: (_) => numberOfTouches = 0,
      onPanEnd: (_) => numberOfTouches = 0,
      onPanUpdate: (details) {
        if (swipeHandled || numberOfTouches > 1) {
          return;
        }
        final dy = details.globalPosition.dy - initialPosition.dy;
        final dx = details.globalPosition.dx - initialPosition.dx;
        //* Vertical Swipe
        if (dy.abs() > dx.abs()) {
          if (dy.abs() < widget.minimumSwipeDistance) {
            return;
          }

          if (dy < 0 && widget.onSwipeUp != null) {
            //* Swipe up
            widget.onSwipeUp!();
            swipeHandled = true;
          } else if (dy > 0 && widget.onSwipeDown != null) {
            //* Swipe down
            widget.onSwipeDown!();
            swipeHandled = true;
          }
        }
        //* Horizontal Swipe
        else if (dy.abs() > dx.abs()) {
          if (dx.abs() < widget.minimumSwipeDistance) {
            return;
          }
          if (dx < 0 && widget.onSwipeLeft != null) {
            //* Swipe left
            widget.onSwipeLeft!();
            swipeHandled = true;
          } else if (dx > 0 && widget.onSwipeRight != null) {
            //* Swipe right
            widget.onSwipeRight!();
            swipeHandled = true;
          }
        }
      },
      child: widget.child,
    );
  }
}
