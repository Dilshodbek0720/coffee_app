import 'package:coffee_app/data/local/storage_repository.dart';
import 'package:coffee_app/data/models/coffee/coffee_model.dart';
import 'package:coffee_app/data/models/order/order_model.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/counter_item.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/custom_appbar.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/image_item.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/rating_item.dart';
import 'package:coffee_app/utils/constants/storage_keys.dart';
import 'package:coffee_app/utils/ui_utils/order_dialog.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/select_type_item.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/size_item.dart';
import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:coffee_app/utils/ui_utils/total_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.coffeeModel});
  final CoffeeModel coffeeModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedIndex = 0;
  int selectSize = 0;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Detail", isLeading: true,isAction: false),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ImageItem(imageUrl: widget.coffeeModel.image, imageSize: 1.2),
                  12.ph,
                  RatingItem(name: widget.coffeeModel.name),
                  4.ph,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: Text(
                      "(\$${widget.coffeeModel.price*count*choicePrice(selectSize)})",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                  ),
                  8.ph,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Text(
                      widget.coffeeModel.description,
                      style: TextStyle(
                          color: AppColors.c_9D9D9D,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  25.ph,
                  SelectTypeItem(valueChanged: (v) {}),
                  25.ph,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Text(
                      "Choose size",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                  20.ph,
                  SizeItem(valueChanged: (v) {
                    setState(() {
                      selectSize = v;
                    });
                  }),
                  20.ph
                ],
              ),
            ),
            12.ph,
            CounterItem(
              count: count,
              onTap: (){
                orderDialog(context: context,orderModel: OrderModel(orderId: '', userId: StorageRepository.getString(StorageKeys.userId), name: widget.coffeeModel.name, type: widget.coffeeModel.type, description: widget.coffeeModel.description, price: widget.coffeeModel.price, image: widget.coffeeModel.image, size: selectSize, count: count, clientName: '', clientNumber: '', region: ''));
            }, minusOnTap: () {
              if(count>1){
                setState(() {
                  count--;
                });
              }
            }, plusOnTap: () {
              setState(() {
                count++;
              });
            },),
            12.ph
          ],
        ),);
  }
}
