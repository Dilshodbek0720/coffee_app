import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterItem extends StatelessWidget {
  const CounterItem({super.key, required this.onTap, required this.minusOnTap, required this.plusOnTap, required this.count});
  final VoidCallback minusOnTap;
  final VoidCallback plusOnTap;
  final VoidCallback onTap;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))
      ),
      child: Row(
        children: [
          InkWell(
            onTap: minusOnTap,
            borderRadius: BorderRadius.circular(6.r),
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: AppColors.c_B0671A.withOpacity(0.15)
              ),
              child: const Icon(Icons.remove, color: AppColors.c_FFB067,),
            ),
          ),
          20.pw,
          Text("$count", style: TextStyle(fontSize: 20.sp),),
          20.pw,
          InkWell(
            onTap: plusOnTap,
            borderRadius: BorderRadius.circular(6.r),
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: AppColors.c_FFB067
              ),
              child: const Icon(Icons.add, color: AppColors.white,),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.c_314D45
              ),
              child: Text("Add to cart", style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.white,
              ),),
            ),
          )
        ],
      ),
    );
  }
}
