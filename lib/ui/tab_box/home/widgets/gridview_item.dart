import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/data/models/coffee/coffee_model.dart';
import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:coffee_app/utils/size/screen_size.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class GridviewItem extends StatelessWidget {
  const GridviewItem({super.key, required this.onTap, required this.coffeeModel});
  final VoidCallback onTap;
  final CoffeeModel coffeeModel;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                  height: 208 * MediaQuery.of(context).size.height / figmaHeight,
                  width: 208 * MediaQuery.of(context).size.height / figmaHeight,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(20.r)),
                  child: CachedNetworkImage(
                    imageUrl: coffeeModel.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Lottie.asset(AppIcons.loading)
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
              ),
            ),
            12.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(coffeeModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Raleway",
                    fontSize: 18.sp,
                    color: AppColors.c_003B40,
                    fontWeight: FontWeight.w700
                ),),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text("\$ ${coffeeModel.price}.00",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 20.sp,
                    color: AppColors.c_003B40,
                    fontWeight: FontWeight.w700
                ),),
            ),
            12.ph,
          ],
        ),
      ),
    );
  }
}
