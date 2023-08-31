import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:katarasa/data/auth/cubit/login_cubit.dart';
import 'package:katarasa/data/dummy/cart_item/cart_item_cubit.dart';
import 'package:katarasa/data/dummy/product/product_cubit.dart';
import 'package:katarasa/data/products/all_product/products_cubit.dart';
import 'package:katarasa/data/products/category_product/category_product_cubit.dart';
import 'package:katarasa/data/products/detail_product/products_detail_cubit.dart';
import 'package:katarasa/utils/cache_storage.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  //init cachestorage
  await CacheStorage.initPref();
  debugPrint('init cache storage');
  TOKEN = CacheStorage.getTokenApi();

  //init network
  await initNetwork();
  debugPrint('init network');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp(appRoute: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRoute}) : super(key: key);

  final AppRouter appRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => ProductCubit()),
          BlocProvider(create: (context) => CategoryProductCubit()),
          BlocProvider(create: (context) => ProductsCubit()),
          BlocProvider(create: (context) => ProductsDetailCubit()),
          BlocProvider(create: (context) => CartItemCubit()),
        ],
        child: Builder(builder: (_) {
          if (Platform.isIOS) {
            return MaterialApp(
                shortcuts: {
                  LogicalKeySet(LogicalKeyboardKey.space): ActivateIntent(),
                },
                debugShowCheckedModeBanner: false,
                title: 'Katarasa Coffee',
                onGenerateRoute: appRoute.onGenerateRoute);
          } else {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Katarasa Coffee',
                onGenerateRoute: appRoute.onGenerateRoute);
          }
        }));
  }
}
