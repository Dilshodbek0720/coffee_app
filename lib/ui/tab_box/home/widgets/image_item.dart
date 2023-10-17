import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({super.key, required this.imageUrl, required this.imageSize});
  final String imageUrl;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / imageSize,
      width: MediaQuery.of(context).size.width / imageSize,
      margin:
      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Padding(
                padding: EdgeInsets.all(20.r),
                child: Lottie.asset(AppIcons.loading)
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
      ),
    );
  }
}
