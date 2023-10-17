import 'package:coffee_app/blocs/order_bloc/order_bloc.dart';
import 'package:coffee_app/data/models/order/order_model.dart';
import 'package:coffee_app/ui/app_routes.dart';
import 'package:coffee_app/ui/auth/widgets/auth_text_field.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/order_text_field.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:coffee_app/utils/ui_utils/show_error_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/tab/tab_cubit.dart';

void orderDialog({required BuildContext context, required OrderModel orderModel}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, state){
          String clientName = '';
          String clientNumber = '';
          String region = '';
          return CupertinoAlertDialog(
            content: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(15.r),
                  child: OrderTextField(hintText: "Enter name", onChanged: (v){
                    clientName = v;
                  }),
                ),
                12.ph,
                Material(
                  borderRadius: BorderRadius.circular(15.r),
                  child: AuthTextField(
                    isAuth: false,
                    focusNode: FocusNode(),
                    hintText: "Phone Number",
                    onChanged: (v) {
                      if (v.length == 12) {
                        FocusNode().unfocus();
                        clientNumber = v;
                      }
                    },
                  ),
                ),
                12.ph,
                Material(
                  borderRadius: BorderRadius.circular(15.r),
                  child: OrderTextField(hintText: "Enter region", onChanged: (v){
                    region = v;
                  }),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18.sp,
                      color: Colors.redAccent
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if(clientName.isNotEmpty&&clientNumber.length==12&&region.isNotEmpty){
                    context.read<TabCubit>().changeTabIndex(1);
                    BlocProvider.of<OrderBloc>(context).add(AddOrderEvent(orderModel: OrderModel(
                      region: region,
                      clientNumber: clientNumber,
                      clientName: clientName,
                      size: orderModel.size,
                      count: orderModel.count,
                      image: orderModel.image,
                      description: orderModel.description,
                      name: orderModel.name,
                      price: orderModel.price,
                      type: orderModel.type,
                      userId: orderModel.userId,
                      orderId: orderModel.orderId,
                    )));
                    Navigator.pushNamed(context, RouteNames.tabBoxScreen);
                  }else{
                    showErrorMessage(message: "Malumotlar to'liq emas", context: context);
                  }
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18.sp,
                      color: Colors.green
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}