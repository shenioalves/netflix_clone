import 'package:flutter/material.dart';

class ResponsiveSize {
  // ignore: unused_field
  static BuildContext? _context;

  static MediaQueryData? _mediaQueryData;

  static double? _screenWidth;

  static double? _screenHeight;

  static double? _paddingTop;

  static double? _paddingBottom;

  static const double _designWidth = 412.0;

  static const double _designHeight = 915.0;

  static void init(BuildContext context) {
    _context = context;
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData!.size.width;
    _screenHeight = _mediaQueryData!.size.height;

    _paddingTop = _mediaQueryData!.padding.top;
    _paddingBottom = _mediaQueryData!.padding.bottom;
  }

  static double width(double width) {
    if (_screenWidth == null) {
      throw Exception(
        "ResponsiveSize não foi inicializado. Chame ResponsiveSize.init(context) primeiro.",
      );
    }

    return (width / _designWidth) * _screenWidth!;
  }

  static double height(double height) {
    if (_screenHeight == null) {
      throw Exception(
        "ResponsiveSize não foi inicializado. Chame ResponsiveSize.init(context) primeiro.",
      );
    }

    return (height / _designHeight) * _screenHeight!;
  }

  static double font(double fontSize) {
    if (_screenWidth == null) {
      throw Exception(
        "ResponsiveSize não foi inicializado. Chame ResponsiveSize.init(context) primeiro.",
      );
    }

    return (fontSize / _designWidth) * _screenWidth!;
  }

  static double get paddingTop {
    if (_paddingTop == null) {
      throw Exception(
        "ResponsiveSize não foi inicializado. Chame ResponsiveSize.init(context) primeiro.",
      );
    }
    return _paddingTop!;
  }

  static double get paddingBottom {
    if (_paddingBottom == null) {
      throw Exception(
        "ResponsiveSize não foi inicializado. Chame ResponsiveSize.init(context) primeiro.",
      );
    }
    return _paddingBottom!;
  }
}

extension ResponsiveContext on BuildContext {
  double responsiveWidth(double width) => ResponsiveSize.width(width);

  double responsiveHeight(double height) => ResponsiveSize.height(height);

  double responsiveFont(double fontSize) => ResponsiveSize.font(fontSize);

  double get responsivePaddingTop => ResponsiveSize.paddingTop;

  double get responsivePaddingBottom => ResponsiveSize.paddingBottom;
}
