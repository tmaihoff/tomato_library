import 'dart:math';

import 'package:flutter/material.dart';

/// CustomPaint widget that scales its CustomPainter content according
/// to the available size.
/// If it's not overridden, the Painter area has a reference size of 200, 200
/// which has to be used for painting. Clipping the content by canvas.clipRect
/// should be considered.
/// If the aspect ratio of the available size is different from the reference
/// size aspect ration, the content is aligned by the alignment property.
class ScaledCustomPaint extends StatelessWidget {
  const ScaledCustomPaint({
    super.key,
    required this.painter,
    this.referenceSize = const Size(200, 200),
    this.alignment = Alignment.center,
    this.foregroundPainter,
    this.isComplex = false,
    this.willChange = false,
    this.repaintBoundary = true,
  });

  final CustomPainter painter;
  final CustomPainter? foregroundPainter;
  final bool isComplex;
  final bool willChange;

  final Size referenceSize;
  final Alignment alignment;
  final bool repaintBoundary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final widthScale = constraints.maxWidth / referenceSize.width;
        final heightScale = constraints.maxHeight / referenceSize.height;
        final scale = min(widthScale, heightScale);

        return AspectRatio(
          aspectRatio: _getAspectRatio(constraints.biggest),
          child: Align(
            alignment: _getAlignment(constraints.biggest, scale),
            child: Transform.translate(
              offset: Offset(
                -scale * referenceSize.width / 2,
                -scale * referenceSize.height / 2,
              ),
              child: Transform.scale(
                scale: scale,
                child: repaintBoundary
                    ? RepaintBoundary(
                        child: CustomPaint(
                          foregroundPainter: foregroundPainter,
                          isComplex: isComplex,
                          willChange: willChange,
                          painter: painter,
                          // size: referenceSize,
                        ),
                      )
                    : CustomPaint(
                        foregroundPainter: foregroundPainter,
                        isComplex: isComplex,
                        willChange: willChange,
                        painter: painter,
                        // size: referenceSize,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Alignment _getAlignment(Size availableSize, double scale) {
    final availableWidth = availableSize.width;
    final availableHeight = availableSize.height;
    final refWidth = referenceSize.width;
    final refHeight = referenceSize.height;
    final diffWidth = availableWidth - refWidth * scale;
    final diffHeight = availableHeight - refHeight * scale;

    final right = diffWidth < 0 ? 0.0 : diffWidth / availableWidth;
    final left = -right;
    final top = diffHeight < 0 ? 0.0 : -diffHeight / availableHeight;
    final bottom = -top;
    const center = 0.0;

    var horizontalAlignment = center;
    var verticalAlignment = center;

    if (alignment.x == Alignment.centerRight.x) {
      horizontalAlignment = right;
    }
    if (alignment.x == Alignment.centerLeft.x) {
      horizontalAlignment = left;
    }
    if (alignment.y == Alignment.topCenter.y) {
      verticalAlignment = top;
    }
    if (alignment.y == Alignment.bottomCenter.y) {
      verticalAlignment = bottom;
    }

    return Alignment(horizontalAlignment, verticalAlignment);
  }

  double _getAspectRatio(Size availableSize) {
    var aspectRatio = availableSize.width / availableSize.height;
    if (aspectRatio.isInfinite || aspectRatio.isNaN || aspectRatio == 0) {
      aspectRatio = referenceSize.width / referenceSize.height;
    }
    return aspectRatio;
  }
}
