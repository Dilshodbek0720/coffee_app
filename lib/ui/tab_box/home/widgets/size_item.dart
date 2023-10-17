import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeItem extends StatefulWidget {
  const SizeItem({super.key, required this.valueChanged});
  final ValueChanged<int> valueChanged;

  @override
  State<SizeItem> createState() => _SizeItemState();
}

class _SizeItemState extends State<SizeItem> {
  int sizeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              sizeIndex = 0;
            });
            widget.valueChanged(sizeIndex);
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
            decoration: BoxDecoration(
                color: sizeIndex == 0 ? AppColors.c_314D45 : AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(width: 1, color: AppColors.c_314D45)
            ),
            child: Text("100 ml", style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: sizeIndex == 0 ? AppColors.white : AppColors.c_314D45
            ),),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              sizeIndex = 1;
            });
            widget.valueChanged(sizeIndex);
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
            decoration: BoxDecoration(
                color: sizeIndex == 1 ? AppColors.c_314D45 : AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
                border: Border.all(width: 1, color: AppColors.c_314D45)
            ),
            child: Text("250 ml", style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: sizeIndex == 1 ? AppColors.white : AppColors.c_314D45
            ),),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              sizeIndex = 2;
            });
            widget.valueChanged(sizeIndex);
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
            decoration: BoxDecoration(
                color: sizeIndex == 2 ? AppColors.c_314D45 : AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
                border: Border.all(width: 1, color: AppColors.c_314D45)
            ),
            child: Text("500 ml", style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: sizeIndex == 2 ? AppColors.white : AppColors.c_314D45
            ),),
          ),
        )
      ],
    );
  }
}
