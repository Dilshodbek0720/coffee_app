import 'package:coffee_app/cubits/tab/tab_cubit.dart';
import 'package:coffee_app/ui/app_routes.dart';
import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../blocs/user_bloc/user_bloc.dart';
import '../../../../cubits/auth/auth_cubit.dart';
import '../../../../data/local/storage_repository.dart';
import '../../../../utils/constants/storage_keys.dart';
import '../../../widgets/global_button.dart';

class LogOutItem extends StatelessWidget {
  const LogOutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            24.ph,
            Text(
              "Are you Log Out?",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            24.ph,
            Row(
              children: [
                Expanded(
                    child: GlobalButton(
                  textColor: AppColors.white,
                  title: 'CANCEL',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  radius: 100.r,
                )),
                12.pw,
                Expanded(
                  child: GlobalButton(
                    title: "OK",
                    textColor: Colors.white,
                    onTap: () async {
                      context.read<UserBloc>().clearUserModelState();
                      StorageRepository.deleteString(StorageKeys.userId);
                      StorageRepository.deleteString(StorageKeys.userRole);
                      await context.read<AuthCubit>().logOutUser();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.registerScreen);
                        context.read<TabCubit>().changeTabIndex(0);
                      }
                    },
                    radius: 100.r,
                  ),
                ),
              ],
            ),
            48.ph,
          ],
        ),
      ),
    );
  }
}
