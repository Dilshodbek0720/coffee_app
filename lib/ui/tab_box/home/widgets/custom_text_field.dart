import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.isSearch,
    required this.hintText,
    required this.onChanged,
  });

  final String hintText;
  final bool isSearch;
  final ValueChanged<String> onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: TextField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.go,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2),
        onChanged: widget.onChanged,
        // inputFormatters: [maskFormatter],
        decoration: InputDecoration(
            counterText: "",
            // contentPadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2),
            prefixIcon: widget.isSearch ? Container(
              height: 24.w,
              width: 24.w,
              padding: EdgeInsets.only(left: 20.w, top: 16.h, bottom: 16.h, right: 10.w),
              child: SvgPicture.asset(AppIcons.searchIcon),
            ) : const SizedBox(),
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