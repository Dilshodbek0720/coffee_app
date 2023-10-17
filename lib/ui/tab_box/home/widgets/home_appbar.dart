import 'package:coffee_app/data/local/storage_repository.dart';
import 'package:coffee_app/ui/app_routes.dart';
import 'package:coffee_app/ui/tab_box/home/sub_screens/add_screen.dart';
import 'package:coffee_app/utils/constants/constants.dart';
import 'package:coffee_app/utils/constants/storage_keys.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/colors/app_colors.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          StorageRepository.getString(StorageKeys.userRole) == AppConstants.client ? RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'Get your ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),
                ),
                TextSpan(
                  text: 'Coffee\n',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.c_FFB067, fontSize: 26.sp),
                ),
                TextSpan(
                  text: ' on one finger tap',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),
                ),
              ],
            ),
          ) : Text("Your coffees", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp, color: AppColors.c_FFB067,), ),
          const Spacer(),
          StorageRepository.getString(StorageKeys.userRole) == AppConstants.client ? ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: SizedBox(
              height: 56.w,
              width: 56 .w,
              child: Image.asset(AppIcons.dialogImage, fit: BoxFit.cover,),
            ),
          ) : InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AddScreen();
              }));
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
                padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.c_B0671A.withOpacity(0.2)
              ),
                child: const Icon(Icons.add)),
          )
        ],
      ),
    );
  }
}
