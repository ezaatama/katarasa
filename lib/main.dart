import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart_item/cart_item_cubit.dart';
import 'package:katarasa/data/product/product_cubit.dart';
import 'package:katarasa/utils/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          BlocProvider(create: (context) => ProductCubit()),
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
