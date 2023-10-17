import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../profile/widgets/log_out.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize{
  const CustomAppBar({super.key, required this.title, required this.isLeading, required this.isAction});
  final String title;
  final bool isLeading;
  final bool isAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: isLeading ? IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: SizedBox(height: 34.w,width: 34.w,child: SvgPicture.asset(AppIcons.arrowBack),),
      ) : null,
      centerTitle: true,
      title: Text(title, style: TextStyle(
        fontFamily: "Raleway",
        fontWeight: FontWeight.w700,
        fontSize: 22.sp,
        color: AppColors.black
      ),),
      actions: [
        isAction ? TextButton(onPressed: (){
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32.r),
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return const LogOutItem();
            },
          );
        }, child: Text("Log Out")) : SizedBox(),
        8.pw
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
