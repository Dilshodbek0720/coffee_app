import 'package:coffee_app/cubits/tab/tab_cubit.dart';
import 'package:coffee_app/ui/tab_box/order/order_screen.dart';
import 'package:coffee_app/ui/tab_box/profile/profile_screen.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/icons/app_icons.dart';
import 'home/home_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  static List<Widget> screens = [];

  @override
  void initState() {
    screens = [
      const HomeScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: context.watch<TabCubit>().state,
          children: screens,
        ),
        bottomNavigationBar: DotNavigationBar(
          items: [
            _getItem(activeIcon: AppIcons.homeIcon, selectedIndex: 0),
            _getItem(activeIcon: AppIcons.shoppingBag, selectedIndex: 1),
            _getItem(activeIcon: AppIcons.profileIcon, selectedIndex: 2)
          ],
          marginR: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 8.h, top: 8.h),
          currentIndex: context.watch<TabCubit>().state,
          onTap: context.read<TabCubit>().changeTabIndex,
        ));
  }

  DotNavigationBarItem _getItem({
    required String activeIcon,
    required int selectedIndex
  }) {
    return DotNavigationBarItem(
      icon: SvgPicture.asset(activeIcon, colorFilter: ColorFilter.mode(selectedIndex == context.watch<TabCubit>().state ? Colors.green : AppColors.c_9D9D9D, BlendMode.srcIn),),
      selectedColor: Colors.green,
      unselectedColor: Colors.black26
    );
  }
}