import 'package:flutter/material.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/core/utils/responsive_size.dart';

class AppTextStyles {
  AppTextStyles._();

  static const _fontFamily = 'Netflix Sans';

  static final _lightBase = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w300,
    color: AppColors.white,
  );

  static final _mediumBase = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static final _boldBase = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  // --- Light Weight ---
  static final lightDisplay32 = _lightBase.copyWith(
    fontSize: ResponsiveSize.font(32),
  );

  static final lightDisplay24 = _lightBase.copyWith(
    fontSize: ResponsiveSize.font(24),
  );

  static final lightHeadline18 = _lightBase.copyWith(
    fontSize: ResponsiveSize.font(18),
  );
  static final lightTitle16 = _lightBase.copyWith(
    fontSize: ResponsiveSize.font(16),
  );
  static final lightBody14 = _lightBase.copyWith(
    fontSize: ResponsiveSize.font(14),
  );
  static final lightLabel12 = _lightBase.copyWith(
    fontSize: ResponsiveSize.font(12),
  );
  static final lightCaption10 = _lightBase.copyWith(
    fontSize: ResponsiveSize.font(10),
  );

  // --- Medium Weight ---
  static final mediumDisplay32 = _mediumBase.copyWith(
    fontSize: ResponsiveSize.font(32),
  );
  static final mediumDisplay24 = _mediumBase.copyWith(
    fontSize: ResponsiveSize.font(24),
  );
  static final mediumHeadline18 = _mediumBase.copyWith(
    fontSize: ResponsiveSize.font(18),
  );
  static final mediumTitle16 = _mediumBase.copyWith(
    fontSize: ResponsiveSize.font(16),
  );
  static final mediumBody14 = _mediumBase.copyWith(
    fontSize: ResponsiveSize.font(14),
  );
  static final mediumLabel12 = _mediumBase.copyWith(
    fontSize: ResponsiveSize.font(12),
  );
  static final mediumCaption10 = _mediumBase.copyWith(
    fontSize: ResponsiveSize.font(10),
  );

  // --- Bold Weight ---
  static final boldDisplay32 = _boldBase.copyWith(
    fontSize: ResponsiveSize.font(32),
  );
  static final boldDisplay24 = _boldBase.copyWith(
    fontSize: ResponsiveSize.font(24),
  );
  static final boldHeadline18 = _boldBase.copyWith(
    fontSize: ResponsiveSize.font(18),
  );
  static final boldTitle16 = _boldBase.copyWith(
    fontSize: ResponsiveSize.font(16),
  );
  static final boldBody14 = _boldBase.copyWith(
    fontSize: ResponsiveSize.font(14),
  );
  static final boldLabel12 = _boldBase.copyWith(
    fontSize: ResponsiveSize.font(12),
  );
  static final boldCaption10 = _boldBase.copyWith(
    fontSize: ResponsiveSize.font(10),
  );
}
