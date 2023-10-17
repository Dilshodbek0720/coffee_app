import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextController extends StatelessWidget {
  const CustomTextController({
    super.key,
    required this.hintText,
    required this.controller,
    required this.textInputType
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: TextField(
        keyboardType: textInputType,
        textInputAction: TextInputAction.go,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2),
        controller: controller,
        decoration: InputDecoration(
            counterText: "",
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: AppColors.c_50)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: AppColors.c_50)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(width: 1.w, color: AppColors.primary)),
            filled: true),
      ),
    );
  }
}