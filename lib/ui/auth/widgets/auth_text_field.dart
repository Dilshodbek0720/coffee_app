import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.focusNode,
    required this.isAuth,
  });

  final String hintText;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool isAuth;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final TextEditingController _controller = TextEditingController();
  bool isFocused = false;
  var maskFormatter = MaskTextInputFormatter(mask: '## ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.go,
      focusNode: widget.focusNode,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: widget.isAuth ? AppColors.white: AppColors.black),
      controller: _controller,
      onChanged: widget.onChanged,
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: widget.isAuth ? AppColors.white: AppColors.black),
          prefixIcon: SizedBox(
            width: 90.w,
            child: Row(
              children: [
                16.pw,
                Text(
                  "+998",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: widget.isAuth ? AppColors.white: AppColors.black),
                )
              ],
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.c_50)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.c_50)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.primary)),
          fillColor: widget.focusNode.hasFocus ? AppColors.orangeTransparent : null,
          filled: true),
    );
  }
}