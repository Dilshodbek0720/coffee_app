import 'package:coffee_app/blocs/order_bloc/order_bloc.dart';
import 'package:coffee_app/data/local/storage_repository.dart';
import 'package:coffee_app/data/models/order/order_model.dart';
import 'package:coffee_app/data/repositories/order_repository.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/custom_appbar.dart';
import 'package:coffee_app/ui/tab_box/order/widgets/order_item.dart';
import 'package:coffee_app/ui/widgets/global_button.dart';
import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/constants/constants.dart';
import 'package:coffee_app/utils/constants/storage_keys.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:coffee_app/utils/ui_utils/total_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Orders",
        isLeading: false,
        isAction: false,
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: StorageRepository.getString(StorageKeys.userRole) ==
                AppConstants.client
            ? context.read<OrderRepo>().getUserOrders()
            : context.read<OrderRepo>().getOrders(),
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> orders = snapshot.data!;
            return orders.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            ...List.generate(
                              orders.length,
                              (index) => OrderItem(
                                imageUrl: orders[index].image,
                                name: orders[index].name,
                                description: orders[index].description,
                                price: orders[index].price *
                                    orders[index].count *
                                    choicePrice(orders[index].size),
                                count: orders[index].count,
                                selectSize: orders[index].size,
                                onTap: (v) {
                                  BlocProvider.of<OrderBloc>(context).add(
                                      DeleteOrderEvent(
                                          orderId: orders[index].orderId));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      StorageRepository.getString(StorageKeys.userRole) == AppConstants.client ? Container(
                        decoration: const BoxDecoration(
                            color: AppColors.c_EDF0EF
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                              child: Row(children: [
                                Text("Grand Total", style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600
                                ),),
                                const Spacer(),
                                Text("\$ ${totalPrice(orders)}", style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                ),),
                              ],),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: GlobalButton(title: "PAY NOW", onTap: (){

                              }),
                            ),
                            8.ph
                          ],
                        ),
                      ) : const SizedBox()
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Lottie.asset(AppIcons.emptyLottie),
                        ),
                      )
                    ],
                  );
          }
          if (snapshot.hasError) {
            return Center(
              child: Lottie.asset(AppIcons.emptyLottie),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
