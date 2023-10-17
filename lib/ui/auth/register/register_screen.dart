import 'package:coffee_app/cubits/auth/auth_cubit.dart';
import 'package:coffee_app/data/models/form/form_status.dart';
import 'package:coffee_app/main.dart';
import 'package:coffee_app/ui/app_routes.dart';
import 'package:coffee_app/ui/auth/widgets/auth_text_field.dart';
import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/local/storage_repository.dart';
import '../../../utils/constants/storage_keys.dart';
import '../../../utils/ui_utils/show_error_message.dart';
import '../../widgets/global_button.dart';
import 'ask_role_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;

  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Stack(children: [
            SizedBox(height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(AppIcons.signIn, fit: BoxFit.cover,),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: 48.h, left: 24.w, right: 24.w, top: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    100.ph,
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white
                      ),
                    ),
                    60.ph,
                    Column(
                      children: [
                        AuthTextField(
                          isAuth: true,
                          focusNode: phoneFocus,
                          hintText: "Phone Number",
                          onChanged: (v) {
                            if (v.length == 12) {
                              phoneFocus.unfocus();
                              context
                                  .read<AuthCubit>()
                                  .updatePhone(v.replaceAll(" ", ""));
                              FocusScope.of(context).requestFocus(passwordFocus);
                            }
                          },
                        ),
                        40.ph,
                        GlobalButton(
                          title: "Sign Up",
                          radius: 100,
                          onTap: () {
                            String canAuthText =
                            context.read<AuthCubit>().canAuthenticate();
                            print(canAuthText);
                            if (canAuthText.isEmpty) {
                              context.read<AuthCubit>().signUp(context);
                            } else {
                            }
                          },
                        )
                      ],
                    ),
                    60.ph,
                  ],
                ),
              ),
            )
          ],);
        },
        listener: (context, state) async {
          if (state.status == FormStatus.authenticated) {
            await StorageRepository.putString(
              StorageKeys.userId,
              FirebaseAuth.instance.currentUser?.uid ?? "",
            );
            if (context.mounted) {
              showRoleDialog(context);
            }
          } else if (state.status == FormStatus.failure) {
            showErrorMessage(message: state.statusMessage, context: context);
          }
        },
      ),
    );
  }
}