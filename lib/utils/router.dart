import 'package:flutter/material.dart';
import 'package:katarasa/screens/auth/forgot_pass/forgot_password_screen.dart';
import 'package:katarasa/screens/auth/login/login_screen.dart';
import 'package:katarasa/screens/auth/register/register_screen.dart';
import 'package:katarasa/screens/bottom_navigation/bottom_nav_screen.dart';
import 'package:katarasa/screens/cart/all_cart_screen.dart';
import 'package:katarasa/screens/cart/cart_screen.dart';
import 'package:katarasa/screens/cart/payment_method_screen.dart';
import 'package:katarasa/screens/product/detail_product_screen.dart';
import 'package:katarasa/screens/product/product_detail_screen.dart';
import 'package:katarasa/screens/profile/about_us_screen.dart';
import 'package:katarasa/screens/profile/add_new_address_screen.dart';
import 'package:katarasa/screens/profile/all_order_screen.dart';
import 'package:katarasa/screens/profile/detail_address_screen.dart';
import 'package:katarasa/screens/profile/detail_oder_screen.dart';
import 'package:katarasa/screens/profile/detail_profile_screen.dart';
import 'package:katarasa/screens/profile/edit_address_screen.dart';
import 'package:katarasa/screens/profile/edit_profile_screen.dart';
import 'package:katarasa/screens/profile/service_screen.dart';
import 'package:katarasa/screens/profile/update_password_screen.dart';
import 'package:katarasa/screens/splash/splashscreen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const BottomNavScreen());
      case '/about-us':
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case '/service':
        return MaterialPageRoute(builder: (_) => const ServiceScreen());
      case '/detail-profile':
        return MaterialPageRoute(builder: (_) => const DetailProfileScreen());
      case '/edit-profile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case '/all-order':
        return MaterialPageRoute(builder: (_) => const AllOrderScreen());
      case '/order-detail':
        return MaterialPageRoute(builder: (_) => const DetailOrderScreen());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/edit-password':
        return MaterialPageRoute(builder: (_) => const UpdatePasswordScreen());
      case '/detail-address':
        return MaterialPageRoute(builder: (_) => const DetailAddressScreen());
      case '/edit-address':
        return MaterialPageRoute(
            builder: (_) => EditAddressScreen(id: settings.arguments as int));
      case '/add-new-address':
        return MaterialPageRoute(builder: (_) => const AddNewAddressScreen());
      case '/detail-product':
        return MaterialPageRoute(
            builder: (_) =>
                DetailProductScreen(id: settings.arguments as String));
      case '/product-detail':
        return MaterialPageRoute(
            builder: (_) =>
                ProductDetailScreen(slug: settings.arguments as String));
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/all-cart':
        return MaterialPageRoute(builder: (_) => const AllCartScreen());
      case '/payment-method':
        return MaterialPageRoute(builder: (_) => const PaymentMethodScreen());
      default:
        return _routeError();
    }
  }

  static Route _routeError() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text("Something went wrong!"),
              ),
            ));
  }
}
