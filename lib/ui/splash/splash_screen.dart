import 'package:coffee_app/data/local/storage_repository.dart';
import 'package:coffee_app/ui/app_routes.dart';
import 'package:coffee_app/utils/constants/storage_keys.dart';
import 'package:flutter/material.dart';
import '../../utils/icons/app_icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init()async{
    await Future.delayed(const Duration(seconds: 2));
    if(context.mounted){
      StorageRepository.getString(StorageKeys.userId).isEmpty ? Navigator.pushReplacementNamed(context, RouteNames.registerScreen) :
      Navigator.pushReplacementNamed(context, RouteNames.tabBoxScreen);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(AppIcons.splash, fit: BoxFit.cover,),
      ),
    );
  }
}
