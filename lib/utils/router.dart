import 'package:flutter/material.dart';
import 'package:katarasa/screens/bottom_navigation/bottom_nav_screen.dart';
import 'package:katarasa/screens/cart/cart_screen.dart';
import 'package:katarasa/screens/cart/payment_method_screen.dart';
import 'package:katarasa/screens/product/detail_product_screen.dart';
import 'package:katarasa/screens/splash/splashscreen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const BottomNavScreen());
      case '/detail-product':
        return MaterialPageRoute(
            builder: (_) =>
                DetailProductScreen(id: settings.arguments as String));
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
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
