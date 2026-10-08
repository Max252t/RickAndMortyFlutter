import 'package:flutter/material.dart';
import 'package:rickandmortyflutter/common/theme/app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(lightScheme);

  static ThemeData get dark => _build(darkScheme);

  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: AppColors.seed,
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: AppColors.seed,
    brightness: Brightness.dark,
  );

  static ThemeData _build(ColorScheme scheme) =>
      ThemeData(colorScheme: scheme, fontFamily: 'Roboto');
}
