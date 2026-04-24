import 'package:diamond_hands_task/utils/utils.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

double w(double value) => Utils.screenWidth * (value / 375);
double h(double value) => Utils.screenHeight * (value / 812);


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,

    primaryColor: AppColors.primaryGold,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    cardColor: AppColors.card,

    dividerColor: AppColors.border,

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textPrimary),
      bodySmall: TextStyle(color: AppColors.textSecondary),
    ),
  );
}