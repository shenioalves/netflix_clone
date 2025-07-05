import 'package:flutter/material.dart';
import 'colors_config.dart';
import 'text_style.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.black,
      primaryColor: AppColors.primaryColor,
      useMaterial3: true,

      // Ícones
      iconTheme: const IconThemeData(color: AppColors.white),

      // Botões
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.white,
          textStyle: AppTextStyles.medium14,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          foregroundColor: AppColors.white,
          textStyle: AppTextStyles.medium14,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // Textos
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.medium30,
        displayMedium: AppTextStyles.medium26,
        titleLarge: AppTextStyles.medium22,
        titleMedium: AppTextStyles.medium14,
        bodyLarge: AppTextStyles.regular13,
        bodyMedium: AppTextStyles.light11,
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        elevation: 0,
        titleTextStyle: AppTextStyles.medium22,
      ),

      // Campos de texto
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.greyDark2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintStyle: AppTextStyles.light11.copyWith(color: AppColors.greyLight1),
      ),
    );
  }
}
