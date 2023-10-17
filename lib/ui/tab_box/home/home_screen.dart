import 'package:coffee_app/data/models/coffee/coffee_model.dart';
import 'package:coffee_app/data/repositories/coffee_repository.dart';
import 'package:coffee_app/ui/app_routes.dart';
import 'package:coffee_app/ui/tab_box/home/sub_screens/add_screen.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/gridview_item.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/home_appbar.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/custom_text_field.dart';
import 'package:coffee_app/utils/constants/constants.dart';
import 'package:coffee_app/utils/constants/storage_keys.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../data/local/storage_repository.dart';
import '../../../utils/ui_utils/search_by_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CoffeeModel> coffees = [];

  @override
  void initState() {
    context.read<CoffeeRepo>().getCoffees().listen((event) {
      coffees = event;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            16.ph,
            const HomeAppbar(),
            10.ph,
            Expanded(
              child: StreamBuilder<List<CoffeeModel>>(
                stream: context.read<CoffeeRepo>().getCoffees(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CoffeeModel>> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.isNotEmpty
                        ? ListView(
                            children: [
                              CustomTextField(
                                  hintText: "Search anything",
                                  isSearch: true,
                                  onChanged: (v) {
                                    setState(() {
                                      coffees = searchByName(snapshot.data!, v);
                                    });
                                  }),
                              coffees.isNotEmpty ?
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 23.w, vertical: 12.h),
                                child: GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 160 / 277.sp,
                                          crossAxisSpacing: 10.w,
                                          mainAxisSpacing: 10.h),
                                  children: List.generate(
                                      coffees.length,
                                      (index) => GridviewItem(
                                          onTap: () {
                                            StorageRepository.getString(
                                                        StorageKeys.userRole) ==
                                                    AppConstants.client
                                                ? Navigator.pushNamed(context,
                                                    RouteNames.detailScreen,
                                                    arguments: coffees[index])
                                                : Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return AddScreen(coffeeModel: coffees[index],);
                                            }));
                                          },
                                          coffeeModel: coffees[index])),
                                ),
                              ) :
                              Column(
                                children: [
                                  35.ph,
                                  Lottie.asset(AppIcons.emptyLottie),
                                ],
                              )
                            ],
                          )
                        : Column(
                            children: [
                              CustomTextField(
                                  hintText: "Search anything",
                                  isSearch: true,
                                  onChanged: (v) {}),
                              Expanded(
                                  child: Center(
                                child: Lottie.asset(AppIcons.emptyLottie),
                              ))
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
            )
          ],
        ),
      ),
    );
  }
}
