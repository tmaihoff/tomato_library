import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tomato_library/tomato_library.dart';

void main() {
  group('paint extension:', () {
    setUp(() async {});

    test('copyWith', () async {
      const blendMode = BlendMode.srcOver;
      const color = Colors.white;
      const colorFilter = ColorFilter.srgbToLinearGamma();
      const filterQuality = FilterQuality.high;
      final imageFilter = ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0);
      const invertColors = true;
      const isAntiAlias = true;
      const maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);
      final shader = const LinearGradient(
        colors: <Color>[Colors.pink, Colors.green],
      ).createShader(
        const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
      );
      const strokeCap = StrokeCap.butt;
      const strokeJoin = StrokeJoin.bevel;
      const strokeWidth = 3.0;
      const style = PaintingStyle.fill;

      final paint = Paint().copyWith(
        blendMode: blendMode,
        color: color,
        colorFilter: colorFilter,
        filterQuality: filterQuality,
        imageFilter: imageFilter,
        invertColors: invertColors,
        isAntiAlias: isAntiAlias,
        maskFilter: maskFilter,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        strokeWidth: strokeWidth,
        style: style,
      );
      expect(paint.blendMode, blendMode);
      expect(paint.blendMode, blendMode);
      expect(paint.color, color);
      expect(paint.colorFilter, colorFilter);
      expect(paint.filterQuality, filterQuality);
      expect(paint.imageFilter, imageFilter);
      expect(paint.invertColors, invertColors);
      expect(paint.isAntiAlias, isAntiAlias);
      expect(paint.maskFilter, maskFilter);
      expect(paint.strokeCap, strokeCap);
      expect(paint.strokeJoin, strokeJoin);
      expect(paint.strokeWidth, strokeWidth);
      expect(paint.style, style);
    });

    // BlendMode? blendMode,
    // Color? color,
    // ColorFilter? colorFilter,
    // FilterQuality? filterQuality,
    // ImageFilter? imageFilter,
    // bool? invertColors,
    // bool? isAntiAlias,
    // MaskFilter? maskFilter,
    // Shader? shader,
    // StrokeCap? strokeCap,
    // StrokeJoin? strokeJoin,
    // double? strokeMiterLimit,
    // double? strokeWidth,
    // PaintingStyle? style,
  });
}
