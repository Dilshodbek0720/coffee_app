import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTextField extends StatefulWidget {
  const OrderTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  State<OrderTextField> createState() => _OrderTextFieldState();
}

class _OrderTextFieldState extends State<OrderTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.go,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2),
      onChanged: widget.onChanged,
      // inputFormatters: [maskFormatter],
      decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText,
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
    );
  }
}