import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/cart/all_cart/all_cart_cubit.dart';
import 'package:katarasa/data/cart/item_cart/item_cart_cubit.dart';
import 'package:katarasa/data/dummy/product/product_cubit.dart';
import 'package:katarasa/data/products/all_product/products_cubit.dart';
import 'package:katarasa/data/products/category_product/category_product_cubit.dart';
import 'package:katarasa/models/dummy/promo_models.dart';
import 'package:katarasa/models/products/products_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/choice_chip.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:katarasa/widgets/product.dart';
import 'package:katarasa/widgets/product_discount.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _topItem = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProduct();
    context.read<ProductsCubit>().getAllProduct(context);
    context.read<CategoryProductCubit>().selectedCategory(context);
    context.read<AllCartCubit>().getAllCart(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                _bodyContent(),
                Positioned(
                  height: 24.0,
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: connected
                      ? const SizedBox()
                      : Container(
                          color: const Color(0xFFEE4400),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Periksa Kembali Jaringan Anda",
                                    style: WHITE_TEXT_STYLE.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
          child: _bodyContent()),
    );
  }

  Widget _bodyContent() {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .350,
                          decoration:
                              const BoxDecoration(color: ColorUI.PRIMARY_GREEN),
                        ),
                        Positioned(
                          right: 0,
                          child: Image.asset(
                            "assets/icons/icon-bg.png",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * .450,
                            height: MediaQuery.of(context).size.height * .250,
                          ),
                        ),
                        Positioned(
                          top: 200,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.25,
                            decoration: const BoxDecoration(
                                color: ColorUI.WHITE,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          //nama, search, point
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 21, right: 21, top: 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Reza Putra Pratama",
                                          style: WHITE_TEXT_STYLE.copyWith(
                                              fontSize: 20,
                                              fontWeight:
                                                  FontUI.WEIGHT_SEMI_BOLD),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: ColorUI.WHITE,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/icons/icon-point.png",
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .060,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .030,
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "250 Points",
                                                style: TextStyle(
                                                    color: ColorUI.GREEN_DARK,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontUI.WEIGHT_MEDIUM),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: ColorUI.WHITE,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.search,
                                            color: ColorUI.BLACK, size: 35),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          //banner promo
                          Container(
                            height: size.height * 0.20,
                            margin: const EdgeInsets.only(left: 16),
                            child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: promoData.length,
                              itemBuilder: (context, index) {
                                PromoModels data = promoData[index];
                                return Container(
                                  margin: const EdgeInsets.all(4),
                                  child: Image.asset(
                                    data.image,
                                    fit: BoxFit.cover,
                                    width: size.width * 0.70,
                                    height: size.height * 0.20,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          //product promo
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product Promo",
                                  style: BLACK_TEXT_STYLE.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    "Lihat semua",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorUI.PRIMARY_GREEN),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: MediaQuery.of(context).size.height * .300,
                            margin: const EdgeInsets.only(left: 16),
                            child: BlocBuilder<ProductCubit, ProductState>(
                              builder: (context, state) {
                                final discountProduct = context
                                    .read<ProductCubit>()
                                    .hasiDiscountProduct();
                                if (state is ProductLoading) {
                                  return _shimmerContent();
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

                          const SizedBox(height: 30),
                          //product utama
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _tabsCategory(),
                              const SizedBox(height: 16),
                              _listProduct(size),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<AllCartCubit, AllCartState>(
                  builder: (context, state) {
                if (state is AllCartLoading) {
                  return _shimmerCartItem();
                } else if (state is AllCartEmpty) {
                  return const SizedBox();
                } else if (state is AllCartLoaded) {
                  final itemName = state.allCartLoaded.items
                      .map((prod) => prod.products.map((e) => e.name))
                      .toString();
                  final removeBrackName =
                      itemName.substring(1, itemName.length - 1);
                  return Positioned(
                    top: MediaQuery.of(context).size.height * .750,
                    left: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        debugPrint("go to cart");
                        Navigator.pushNamed(context, '/all-cart');
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xFFA9EFBB),
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${state.allCartLoaded.totalData.toString()} item",
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(removeBrackName,
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_LIGHT),
                                      maxLines: 1),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Text(
                                    state.allCartLoaded.totalCartCurrencyFormat,
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontUI.WEIGHT_BOLD)),
                                const SizedBox(width: 6),
                                const Icon(Icons.shopping_bag_outlined,
                                    color: ColorUI.BLACK, size: 20)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              })
            ],
          ),
        ));
  }

  Widget _tabsCategory() {
    return BlocBuilder<CategoryProductCubit, CategoryProductState>(
        builder: (builder, state) {
      if (state is CategoryProductSelected) {
        return Container(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.categories.asMap().entries.map((e) {
                  int index = e.key;
                  String product = e.value;

                  return CategoryType(
                      title: product, selected: _topItem == index, cb: () {});
                }).toList()),
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget _listProduct(Size devices) {
    return Container(
      child: _buildList(devices),
    );
  }

  Widget _buildList(Size devices) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return _shimmerContent();
        } else if (state is ProductsSuccess) {
          Map<String, List<ProductRequest>> mappedProduk = groupBy(
              state.allProduct, (ProductRequest produk) => produk.category);
          List<MapEntry<String, List<ProductRequest>>> prod =
              mappedProduk.entries.toList();
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: prod.length,
              itemBuilder: (context, index) {
                return _produkList(prod[index].value);
              });
        }

        return const SizedBox();
      },
    );
  }

  Widget _produkList(List<ProductRequest> prods) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: prods.length,
        itemBuilder: (context, index) {
          return Product(
            products: prods[index],
            addTocart: BlocConsumer<ItemCartCubit, ItemCartState>(
                listener: (context, state) {
              if (state is ItemCartUpdated) {
                showToast(text: state.cartUpdated, state: ToastStates.SUCCESS);
                Navigator.pushNamed(context, '/all-cart');
              } else if (state is ItemCartError) {
                showToast(text: state.errItemCart, state: ToastStates.ERROR);
              }
            }, builder: (context, state) {
              return InkWell(
                onTap: () {
                  context
                      .read<ItemCartCubit>()
                      .addToCartHome(prods[index].id, "", "1", context);
                },
                child: Image.asset("assets/icons/icon_add.png",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * .070,
                    height: MediaQuery.of(context).size.height * .035),
              );
            }),
          );
        });
  }

  Widget _shimmerContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
        baseColor: ColorUI.SHIMMER_BASE,
        highlightColor: ColorUI.SHIMMER_HIGHLIGHT,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 6,
        ),
      ),
    );
  }

  Widget _shimmerCartItem() {
    return Positioned(
      top: MediaQuery.of(context).size.height * .750,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.060,
        child: Shimmer.fromColors(
            baseColor: ColorUI.SHIMMER_BASE,
            highlightColor: ColorUI.SHIMMER_HIGHLIGHT,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorUI.SHIMMER_BASE,
              ),
            )),
      ),
    );
  }
}
