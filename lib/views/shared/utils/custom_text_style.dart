// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stockaxis_flutter_app/views/shared/constants/app_colors.dart';

class CustomTextstyle {
  // Color white
  static TextStyle textStyle_14_600_white = TextStyle(
      fontSize: 14, color: AppColors.color_white, fontWeight: FontWeight.w600);

// Color black
  static TextStyle titile_black_bold = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.color_primary_black);

  static TextStyle subTitile_black_regular = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.color_primary_black);

  static TextStyle description_black_regular = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.color_primary_black);

  // Color grey
  static TextStyle subTitile_grey_regular = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.color_grey);

  static TextStyle dropDown_grey = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.color_grey);

  static TextStyle subTitile_grey_subregular = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.color_grey);
}
