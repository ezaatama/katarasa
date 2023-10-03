import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:katarasa/data/auth/forgot_pass/forgot_pass_cubit.dart';
import 'package:katarasa/data/auth/login/login_cubit.dart';
import 'package:katarasa/data/auth/register/register_cubit.dart';
import 'package:katarasa/data/cart/all_cart/all_cart_cubit.dart';
import 'package:katarasa/data/cart/item_cart/item_cart_cubit.dart';
import 'package:katarasa/data/checkout/data_checkout/data_checkout_cubit.dart';
import 'package:katarasa/data/checkout/data_shipping/data_shipping_cubit.dart';
import 'package:katarasa/data/dummy/cart_item/cart_item_cubit.dart';
import 'package:katarasa/data/dummy/product/product_cubit.dart';
import 'package:katarasa/data/order/all_order/data_order_cubit.dart';
import 'package:katarasa/data/order/detail_order/detail_order_cubit.dart';
import 'package:katarasa/data/products/all_product/products_cubit.dart';
import 'package:katarasa/data/products/category_product/category_product_cubit.dart';
import 'package:katarasa/data/products/detail_product/products_detail_cubit.dart';
import 'package:katarasa/data/profile/add_address/add_address_cubit.dart';
import 'package:katarasa/data/profile/data_profile/profile_cubit.dart';
import 'package:katarasa/data/profile/detail_address/detail_address_cubit.dart';
import 'package:katarasa/data/profile/edit_address/edit_address_cubit.dart';
import 'package:katarasa/data/profile/select_address/kabupaten/kabupaten_cubit.dart';
import 'package:katarasa/data/profile/select_address/kecamatan/kecamatan_cubit.dart';
import 'package:katarasa/data/profile/select_address/kota/kota_cubit.dart';
import 'package:katarasa/data/profile/select_address/provinsi/provinsi_cubit.dart';
import 'package:katarasa/data/profile/ubah_password/ubah_password_cubit.dart';
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
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => ForgotPassCubit()),
          BlocProvider(create: (context) => UbahPasswordCubit()),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => DetailAddressCubit()),
          BlocProvider(create: (context) => AddAddressCubit()),
          BlocProvider(create: (context) => EditAddressCubit()),
          BlocProvider(create: (context) => ProvinsiCubit()),
          BlocProvider(create: (context) => KotaCubit()),
          BlocProvider(create: (context) => KabupatenCubit()),
          BlocProvider(create: (context) => KecamatanCubit()),
          BlocProvider(create: (context) => ProductCubit()),
          BlocProvider(create: (context) => AllCartCubit()),
          BlocProvider(create: (context) => ItemCartCubit()),
          BlocProvider(create: (context) => CategoryProductCubit()),
          BlocProvider(create: (context) => ProductsCubit()),
          BlocProvider(create: (context) => ProductsDetailCubit()),
          BlocProvider(create: (context) => CartItemCubit()),
          BlocProvider(create: (context) => DataCheckoutCubit()),
          BlocProvider(create: (context) => DataShippingCubit()),
          BlocProvider(create: (context) => DataOrderCubit()),
          BlocProvider(create: (context) => DetailOrderCubit()),
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
