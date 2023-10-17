import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTypeItem extends StatefulWidget {
  const SelectTypeItem({super.key, required this.valueChanged});
  final ValueChanged<int> valueChanged;

  @override
  State<SelectTypeItem> createState() => _SelectTypeItemState();
}

class _SelectTypeItemState extends State<SelectTypeItem> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: (){
            setState(() {
              selectedIndex = 0;
            });
            widget.valueChanged(selectedIndex);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: SizedBox(height: 75.w, width: 75.w, child: Image.asset(AppIcons.coffeeBeans, color: selectedIndex==0 ? Colors.redAccent : null,),),
        ),
        InkWell(
          onTap: (){
            setState(() {
              selectedIndex = 1;
            });
            widget.valueChanged(selectedIndex);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: SizedBox(height: 75.w, width: 75.w, child: Image.asset(AppIcons.milkCarton, color: selectedIndex==1 ? Colors.redAccent : null,),),
        ),
        InkWell(
          onTap: (){
            setState(() {
              selectedIndex = 2;
            });
            widget.valueChanged(selectedIndex);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: SizedBox(height: 75.w, width: 75.w, child: Image.asset(AppIcons.cream, color: selectedIndex==2 ? Colors.redAccent : null,),),
        )
      ],);
  }
}
