import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';

abstract final class AppBorders {
  static const thin = BorderSide(color: AppColors.darkBorder);
  static const focused = BorderSide(color: AppColors.primary, width: 1.5);
  static const error = BorderSide(color: AppColors.error);
}