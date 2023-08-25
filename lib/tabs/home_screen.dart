import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart_item/cart_item_cubit.dart';
import 'package:katarasa/data/product/product_cubit.dart';
import 'package:katarasa/models/promo_models.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/product.dart';
import 'package:katarasa/widgets/product_discount.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProduct();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _currentPage++;
      if (_currentPage >= 3) {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.20,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (val) {
                      setState(() {
                        _currentPage = val;
                      });
                    },
                    itemCount: promoData.length,
                    itemBuilder: (context, index) {
                      PromoModels data = promoData[index];
                      return Stack(
                        children: [
                          Image.asset(
                            data.image,
                            fit: BoxFit.cover,
                            width: size.width,
                            height: size.height * 0.20,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                promoData.length,
                                (index) => _buildDot(index: index),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Promo Spesial",
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontSize: 18, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .250,
                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      final discountProduct =
                          context.read<ProductCubit>().hasiDiscountProduct();
                      if (state is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductSuccess) {
                        if (discountProduct.isNotEmpty) {
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: discountProduct.length,
                              itemBuilder: (context, index) {
                                return ProductDiscount(
                                    products: discountProduct[index]);
                              });
                        }
                      }

                      return const Center(
                          child: Text("Tidak ada promo hari ini"));
                    },
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Rekomendasi Untuk Kamu",
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontSize: 18, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                ),
                const SizedBox(height: 10),
                BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductSuccess) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.product.length,
                          itemBuilder: (context, index) {
                            return Product(products: state.product[index]);
                          });
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<CartItemCubit, CartItemState>(
          builder: (context, state) {
            if (state is CartItemUpdated) {
              int totalPrice = state.cartItems.fold(
                  0,
                  (total, item) =>
                      total +
                      (item.product.discount == null
                          ? item.product.price * item.quantity
                          : item.product.discount! * item.quantity));
              String productAdded =
                  state.cartItems.map((e) => e.product.title).toString();
              return state.cartItems.isEmpty
                  ? const SizedBox()
                  : Positioned(
                      top: MediaQuery.of(context).size.height * .750,
                      left: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          debugPrint("go to cart");
                          Navigator.pushNamed(context, '/cart');
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: ColorUI.MEDIUM_BROWN,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${state.cartItems.length.toString()} item",
                                      style: WHITE_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(productAdded,
                                        style: WHITE_TEXT_STYLE.copyWith(
                                            fontWeight: FontUI.WEIGHT_LIGHT),
                                        maxLines: 1),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                children: [
                                  Text("Rp ${totalPrice.toRupiah()}",
                                      style: WHITE_TEXT_STYLE.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontUI.WEIGHT_BOLD)),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.shopping_bag_outlined,
                                      color: ColorUI.WHITE, size: 20)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            }
            return const SizedBox();
          },
        ),
      ],
    )));
  }

  AnimatedContainer _buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 8 : 8,
      decoration: BoxDecoration(
          color: _currentPage == index
              ? ColorUI.BROWN
              : ColorUI.WHITE.withOpacity(0.60),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
