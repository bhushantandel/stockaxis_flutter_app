import 'package:flutter/material.dart';
import 'package:stockaxis_flutter_app/views/shared/constants/app_colors.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.color_off_white,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.color_white),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        color: AppColors.color_primary_black,
        fontSize: 18,
        fontWeight: FontWeight.w600),
    backgroundColor: AppColors.color_grey_light,
    foregroundColor: AppColors.color_primary_black,
  ),
  iconTheme: IconThemeData(
    color: AppColors.color_grey,
    size: 24,
  ),
  useMaterial3: true,
);
