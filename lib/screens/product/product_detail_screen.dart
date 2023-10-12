import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/cart/item_cart/item_cart_cubit.dart';
import 'package:katarasa/data/products/detail_product/products_detail_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:katarasa/widgets/product_other.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.slug});

  final String slug;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    context.read<ProductsDetailCubit>().getDetailProduct(context, widget.slug);
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      backgroundColor: ColorUI.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                size: 24, color: ColorUI.BLACK),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Detail Produk",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child:
          BlocBuilder<ProductsDetailCubit, ProductsDetailState>(
              builder: (context, state) {
        if (state is ProductsDetailLoading) {
          return const LoaderIndicator();
        } else if (state is ProductsDetailSuccess) {
          final image = state.productsDetail.image;
          final data = state.productsDetail;
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.8,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (val) {
                            setState(() {
                              _currentPage = val;
                            });
                          },
                          itemCount: image.length,
                          itemBuilder: (context, index) {
                            final idxImage = image[index];
                            return Stack(
                              children: [
                                StdImage(
                                    imageUrl: idxImage,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        2.8),
                                Positioned(
                                  bottom: 40,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      image.length,
                                      (index) => _buildDot(index: index),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 3,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: ColorUI.WHITE,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.productsDetail.category.name,
                                    style: NAVY_TEXT_STYLE.copyWith(
                                        fontWeight: FontUI.WEIGHT_MEDIUM),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  state.productsDetail.name,
                                                  style:
                                                      BLACK_TEXT_STYLE.copyWith(
                                                          fontSize: 20,
                                                          fontWeight: FontUI
                                                              .WEIGHT_BOLD),
                                                ),
                                                const Icon(Icons.star,
                                                    size: 22,
                                                    color: Colors.yellow),
                                                Text(
                                                  state.productsDetail.rating,
                                                  style:
                                                      BLACK_TEXT_STYLE.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontUI
                                                              .WEIGHT_MEDIUM),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              state.productsDetail.store
                                                  .location,
                                              textAlign: TextAlign.left,
                                              style: BLACK_TEXT_STYLE.copyWith(
                                                  color: ColorUI.BLACK
                                                      .withOpacity(.60),
                                                  fontWeight:
                                                      FontUI.WEIGHT_LIGHT),
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          state.productsDetail.isDiscount ==
                                                  false
                                              ? Text(
                                                  state.productsDetail.price,
                                                  style: RED_TEXT_STYLE.copyWith(
                                                      fontSize: 24,
                                                      fontWeight: FontUI
                                                          .WEIGHT_SEMI_BOLD),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                      Text(
                                                        state.productsDetail
                                                            .priceDiscount,
                                                        style: RED_TEXT_STYLE
                                                            .copyWith(
                                                                fontSize: 24,
                                                                fontWeight: FontUI
                                                                    .WEIGHT_SEMI_BOLD),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        state.productsDetail
                                                            .price,
                                                        style: BLACK_TEXT_STYLE.copyWith(
                                                            fontSize: 18,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontWeight: FontUI
                                                                .WEIGHT_LIGHT),
                                                      ),
                                                    ])
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Deskripsi Produk",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontUI.WEIGHT_BOLD),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        state.productsDetail.description,
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight: FontUI.WEIGHT_MEDIUM),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            "Brand: ",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_SEMI_BOLD),
                                          ),
                                          Text(
                                            state.productsDetail.brand,
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_MEDIUM),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            "Stok Produk: ",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_SEMI_BOLD),
                                          ),
                                          Text(
                                            "${state.productsDetail.stock}",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_MEDIUM),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            "Berat Produk: ",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_SEMI_BOLD),
                                          ),
                                          Text(
                                            state.productsDetail.weight,
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_MEDIUM),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            "Masa Pengemasan: ",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_SEMI_BOLD),
                                          ),
                                          Text(
                                            "${state.productsDetail.masaPengemasan} hari",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_MEDIUM),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            "Dilihat: ",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_SEMI_BOLD),
                                          ),
                                          Icon(
                                            Icons.remove_red_eye_rounded,
                                            size: 20,
                                            color:
                                                ColorUI.BLACK.withOpacity(.60),
                                          ),
                                          Text(
                                            state.productsDetail.totalSeen,
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_MEDIUM),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      state.productsDetail.store.freeOngkir ==
                                              'Y'
                                          ? Row(
                                              children: [
                                                Image.asset(
                                                    "assets/icons/free-delivery.png",
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .050,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .025),
                                                const SizedBox(width: 7),
                                                Text(
                                                  "Free Ongkir",
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      BLACK_TEXT_STYLE.copyWith(
                                                          fontWeight: FontUI
                                                              .WEIGHT_SEMI_BOLD),
                                                  maxLines: 2,
                                                )
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Review Produk",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontUI.WEIGHT_BOLD),
                                        ),
                                        const SizedBox(height: 5),
                                        state.productsDetail.review.isEmpty
                                            ? const Center(
                                                child: Text(
                                                    "Belum ada review untuk produk ini."))
                                            : const SizedBox()
                                      ]),
                                  const SizedBox(height: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Produk Lainnya",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontUI.WEIGHT_BOLD),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .250,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            // scrollDirection: Axis.horizontal,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state.productsDetail
                                                .otherProduct.length,
                                            itemBuilder: (context, index) {
                                              return ProductOther(
                                                  products: state.productsDetail
                                                      .otherProduct[index]);
                                            }),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * .080,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorUI.GREY.withOpacity(.70),
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              iconSize: 35,
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border_outlined),
                              color: Colors.red),
                          BlocConsumer<ItemCartCubit, ItemCartState>(
                            listener: (context, state) {
                              if (state is ItemCartUpdated) {
                                Navigator.pop(context);
                                showToast(
                                    text: state.cartUpdated,
                                    state: ToastStates.SUCCESS);
                                Navigator.pushNamed(context, '/all-cart');
                              } else if (state is ItemCartError) {
                                showToast(
                                    text: state.errItemCart,
                                    state: ToastStates.ERROR);
                              }
                            },
                            builder: (context, state) {
                              return Flexible(
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<ItemCartCubit>()
                                        .addToCart(data, "", context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade700,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Keranjang",
                                              style: WHITE_TEXT_STYLE.copyWith(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontUI.WEIGHT_MEDIUM)),
                                          const SizedBox(width: 5),
                                          data.isDiscount == false
                                              ? Flexible(
                                                  child: Text(data.price,
                                                      style: WHITE_TEXT_STYLE
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight: FontUI
                                                                  .WEIGHT_MEDIUM)))
                                              : Flexible(
                                                  child: Text(
                                                      data.priceDiscount,
                                                      style: WHITE_TEXT_STYLE
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight: FontUI
                                                                  .WEIGHT_MEDIUM)))
                                        ]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          );
        }
        return const SizedBox();
      })),
    );
  }

  AnimatedContainer _buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 8 : 8,
      decoration: BoxDecoration(
          color: _currentPage == index
              ? ColorUI.WHITE
              : ColorUI.WHITE.withOpacity(0.40),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
