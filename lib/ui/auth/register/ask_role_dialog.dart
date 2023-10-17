import 'package:coffee_app/ui/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../data/local/storage_repository.dart';
import '../../../data/models/user/user_fieldkey.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/storage_keys.dart';
import '../../../utils/icons/app_icons.dart';

void showRoleDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: Text(
          "Admin or Client?",
          style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 20.sp,
            fontWeight: FontWeight.bold
          ),
        ),
        title: Image.asset(AppIcons.dialogImage),
        actions: [
          TextButton(
            onPressed: () {
              StorageRepository.putString(
                  StorageKeys.userRole, AppConstants.admin);
              // await StorageRepository.putString(
              //   StorageKeys.userId,
              //   FirebaseAuth.instance.currentUser?.uid ?? "",
              // );
              context.read<UserBloc>().add(UpdateCurrentUserEvent(
                  fieldKey: UserFieldKeys.userId,
                  value: StorageRepository.getString(
                    StorageKeys.userId,
                  )));
              context.read<UserBloc>().add(AddUserEvent());
              Navigator.pushReplacementNamed(context, RouteNames.tabBoxScreen);
            },
            child: Text(
              "Admin",
              style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 18.sp
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              StorageRepository.putString(
                  StorageKeys.userRole, AppConstants.client);
              context.read<UserBloc>().add(UpdateCurrentUserEvent(
                  fieldKey: UserFieldKeys.userId,
                  value: StorageRepository.getString(
                    StorageKeys.userId,
                  )));
              context.read<UserBloc>().add(AddUserEvent());
              Navigator.pushReplacementNamed(context, RouteNames.tabBoxScreen);
            },
            child: Text(
              "Client",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18.sp
              ),
            ),
          ),
        ],
      );
    },
  );
}