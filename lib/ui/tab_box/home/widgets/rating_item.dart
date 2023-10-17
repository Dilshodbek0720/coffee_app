import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingItem extends StatelessWidget {
  const RatingItem({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black),
          ),
          const Spacer(),
          SizedBox(
            height: 20.r,
            width: 20.r,
            child: SvgPicture.asset(AppIcons.starIcon),
          ),
          Text(
            "5.0",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: AppColors.black),
          )
        ],
      ),
    );
  }
}
