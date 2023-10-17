import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/blocs/coffee_bloc/coffee_bloc.dart';
import 'package:coffee_app/data/models/coffee/coffee_model.dart';
import 'package:coffee_app/data/models/form/form_status.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/custom_text_controller.dart';
import 'package:coffee_app/ui/tab_box/home/widgets/image_item.dart';
import 'package:coffee_app/ui/widgets/global_button.dart';
import 'package:coffee_app/utils/colors/app_colors.dart';
import 'package:coffee_app/utils/icons/app_icons.dart';
import 'package:coffee_app/utils/size/size_extension.dart';
import 'package:coffee_app/utils/ui_utils/loading_dialog.dart';
import 'package:coffee_app/utils/ui_utils/show_error_message.dart';
import 'package:coffee_app/utils/ui_utils/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/models/universal_data.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key, this.coffeeModel});
  final CoffeeModel? coffeeModel;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  ImagePicker picker = ImagePicker();
  String image = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    if(widget.coffeeModel!=null){
      image = widget.coffeeModel!.image;
      nameController.text = widget.coffeeModel!.name;
      descriptionController.text = widget.coffeeModel!.description;
      typeController.text = widget.coffeeModel!.type;
      priceController.text = widget.coffeeModel!.price.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.coffeeModel==null ? "Add Screen" : "Update Screen", style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppIcons.arrowBack),
        ),
        actions: [
          widget.coffeeModel!=null ? IconButton(onPressed: (){
            BlocProvider.of<CoffeeBloc>(context).add(DeleteCoffeeEvent(coffeeId: widget.coffeeModel!.coffeeId));
          }, icon: const Icon(Icons.delete, color: Colors.red,)) : const SizedBox(),
          6.pw
        ],
      ),
      body: BlocConsumer<CoffeeBloc, CoffeeStates>(
        builder: (context, state){
          return ListView(
            children: [
              12.ph,
              CustomTextController(hintText: "Coffee Name", controller: nameController, textInputType: TextInputType.text,),
              CustomTextController(hintText: "Description", controller: descriptionController, textInputType: TextInputType.text,),
              CustomTextController(hintText: "Type of coffee", controller: typeController, textInputType: TextInputType.text,),
              CustomTextController(hintText: "Price", controller: priceController, textInputType: TextInputType.number,),
              TextButton(onPressed: (){
                showBottomSheetDialog();
              }, child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Select Image"),
                  10.pw,
                  const Icon(Icons.photo_outlined)
                ],
              )),
              image.isNotEmpty ? Container(
                height: MediaQuery.of(context).size.width / 1.8,
                width: MediaQuery.of(context).size.width / 1.8,
                margin:
                EdgeInsets.symmetric(horizontal: 80.w, vertical: 20.h),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.c_003B40),
                    borderRadius: BorderRadius.circular(30.r)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Padding(
                          padding: EdgeInsets.all(20.r),
                          child: Lottie.asset(AppIcons.loading)
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                ),
              ) : const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: GlobalButton(title: widget.coffeeModel==null ? "Add Coffee" : "Update Coffee", onTap: (){
                  if(image.isNotEmpty&&nameController.text.isNotEmpty&&descriptionController.text.isNotEmpty&&typeController.text.isNotEmpty&&priceController.text.isNotEmpty){
                    if(widget.coffeeModel==null){
                      BlocProvider.of<CoffeeBloc>(context).add(AddCoffeeEvent(coffeeModel: CoffeeModel(
                          coffeeId: '',
                          type: typeController.text,
                          price: int.parse(priceController.text),
                          name: nameController.text,
                          description: descriptionController.text,
                          image: image
                      )));
                    }else{
                      BlocProvider.of<CoffeeBloc>(context).add(UpdateCoffeeEvent(coffeeModel: CoffeeModel(
                          coffeeId: widget.coffeeModel!.coffeeId,
                          type: typeController.text,
                          price: int.parse(priceController.text),
                          name: nameController.text,
                          description: descriptionController.text,
                          image: image
                      )));
                    }
                  }else{
                    showErrorMessage(message: "Malumotni to'liq kiriting!", context: context);
                  }
                }),
              )
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            debugPrint("Success");
            Navigator.pop(context);
          }
          if (state.status == FormStatus.failure) {
            showErrorMessage(message: "Xatolik yuz berdi!", context: context);
          }
        },
      )
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: AppColors.c_B0671A,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt, color: Colors.white,),
                title: const Text("Select from Camera", style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo, color: Colors.white,),
                title: const Text("Select from Gallery", style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );
    if(context.mounted){
      showLoading(context: context);
    }
    if (xFile != null && context.mounted) {
      UniversalData data = await imageUploader(xFile);
      setState(() {
        image = data.data as String;
      });
    }
    if(context.mounted){
      hideLoading(context: context);
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if(context.mounted){
      showLoading(context: context);
    }
    if (xFile != null && context.mounted) {
      UniversalData data = await imageUploader(xFile);
      setState(() {
        image = data.data as String;
      });
    }
    if(context.mounted){
      hideLoading(context: context);
    }
  }
}
