import 'package:coffee_app/ui/tab_box/home/widgets/custom_appbar.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: false,
        title: "Profile",
        isAction: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            25.ph,
            SizedBox(
              height: 170.w,
              width: 170.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: Image.asset(
                  AppIcons.profile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            25.ph,
            Text("Alibek Valiyev", style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              fontFamily: "Raleway",
            ),),
            8.ph,
            Text("alibek@gmail.com", style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.w600,
              fontFamily: "Raleway",
              color: Colors.black.withOpacity(0.5)
            ),),
            25.ph,
            Text("Biz bilan bog'lanish: + 99 986 08 99", style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                // fontFamily: "Raleway",
                color: Colors.black.withOpacity(0.8)
            ),),
          ],
        ),
      ),
    );
  }
}
