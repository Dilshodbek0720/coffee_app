import 'package:coffee_app/blocs/coffee_bloc/coffee_bloc.dart';
import 'package:coffee_app/blocs/order_bloc/order_bloc.dart';
import 'package:coffee_app/blocs/user_bloc/user_bloc.dart';
import 'package:coffee_app/data/repositories/coffee_repository.dart';
import 'package:coffee_app/data/repositories/order_repository.dart';
import 'package:coffee_app/data/repositories/user_repo.dart';
import 'package:coffee_app/ui/app_routes.dart';
import 'package:coffee_app/utils/size/screen_size.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cubits/auth/auth_cubit.dart';
import 'cubits/tab/tab_cubit.dart';
import 'data/local/storage_repository.dart';
import 'data/repositories/auth_repository.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StorageRepository.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => AuthRepository()),
      RepositoryProvider(create: (context) => UserRepo()),
      RepositoryProvider(create: (context) => CoffeeRepo()),
      RepositoryProvider(create: (context) => OrderRepo())
    ], child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TabCubit()),
          BlocProvider(create: (context) => AuthCubit(context.read<AuthRepository>())),
          BlocProvider(create: (context) => UserBloc(userRepo: context.read<UserRepo>())),
          BlocProvider(create: (context) => CoffeeBloc(coffeeRepo: context.read<CoffeeRepo>())),
          BlocProvider(create: (context) => OrderBloc(orderRepo: context.read<OrderRepo>()))
        ],
        child: const MyApp()
    ));
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(figmaWidth, figmaHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}