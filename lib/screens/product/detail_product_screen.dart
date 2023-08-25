import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart_item/cart_item_cubit.dart';
import 'package:katarasa/data/product/product_cubit.dart';
import 'package:katarasa/models/variant_models.dart';
import 'package:katarasa/models/cart_models.dart';
import 'package:katarasa/models/ice_models.dart';
import 'package:katarasa/models/product_models.dart';
import 'package:katarasa/models/sizes_models.dart';
import 'package:katarasa/models/sugar_models.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/chip_product.dart';
import 'package:katarasa/widgets/customize_optional.dart';
import 'package:katarasa/widgets/toast_comp.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<ProductCubit>().findById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final productLoaded = context.read<ProductCubit>().findById(widget.id);
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductSuccess) {
          return Scaffold(
            backgroundColor: ColorUI.BACKGROUND_COLOR,
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              child: Image.asset(
                                productLoaded.image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ],
                        ),
                        SafeArea(
                            child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorUI.WHITE,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/home');
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_outlined),
                                        color: ColorUI.BLACK),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorUI.WHITE,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            productLoaded.toggleStatus();
                                          });
                                        },
                                        icon: Icon(productLoaded.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined),
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.fromLTRB(16, 200, 16, 0),
                              decoration: BoxDecoration(
                                  color: ColorUI.WHITE,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productLoaded.category,
                                    style: BROWN_TEXT_STYLE.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontUI.WEIGHT_MEDIUM),
                                  ),
                                  const SizedBox(height: 4),
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
                                            Text(
                                              productLoaded.title,
                                              style: BLACK_TEXT_STYLE.copyWith(
                                                  fontSize: 26,
                                                  fontWeight:
                                                      FontUI.WEIGHT_BOLD),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              productLoaded.ingredient,
                                              style: BLACK_TEXT_STYLE.copyWith(
                                                  fontWeight:
                                                      FontUI.WEIGHT_LIGHT),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Column(
                                        children: [
                                          productLoaded.discount == null
                                              ? Text(
                                                  "Rp ${productLoaded.price.toRupiah()}",
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
                                                        "Rp ${productLoaded.discount!.toRupiah()}",
                                                        style: RED_TEXT_STYLE
                                                            .copyWith(
                                                                fontSize: 24,
                                                                fontWeight: FontUI
                                                                    .WEIGHT_SEMI_BOLD),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "Rp ${productLoaded.price.toRupiah()}",
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
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                              decoration: BoxDecoration(
                                  color: ColorUI.WHITE,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Customize",
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Variant",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: variant.map((variant) {
                                              return ChipProduct(
                                                filter: variant.tittle,
                                                value: variant.tittle,
                                                groupValue: hasTittle,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    hasTittle = value!;
                                                  });
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Size",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: sizes.map((size) {
                                              return ChipProduct(
                                                filter: size.tittle,
                                                value: size.tittle,
                                                groupValue: hasTemp,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    hasTemp = value!;
                                                  });
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Sugar",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: sugars.map((sugar) {
                                              return ChipProduct(
                                                filter: sugar.tittle,
                                                value: sugar.tittle,
                                                groupValue: hasSugar,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    hasSugar = value!;
                                                  });
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Ice",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: ices.map((ice) {
                                              return ChipProduct(
                                                filter: ice.tittle,
                                                value: ice.tittle,
                                                groupValue: hasIces,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    hasIces = value!;
                                                  });
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: BlocBuilder<CartItemCubit, CartItemState>(
                        builder: (context, state) {
                      if (state is CartItemUpdated) {
                        return Container(
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
                              children: [
                                Flexible(
                                  child: InkWell(
                                    onTap: () {
                                      print("go to cart");
                                      context
                                          .read<CartItemCubit>()
                                          .addToCart(productLoaded);
                                      // context
                                      //     .read<CartCubit>()
                                      //     .addItem(productLoaded);
                                      Navigator.pop(context);
                                      showToast(
                                          text:
                                              'Produk berhasil ditambah! Cek keranjang Anda',
                                          state: ToastStates.SUCCESS);
                                      Navigator.pushNamed(context, '/cart');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 5),
                                      height:
                                          MediaQuery.of(context).size.height,
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
                                                style:
                                                    WHITE_TEXT_STYLE.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontUI
                                                            .WEIGHT_MEDIUM)),
                                            const SizedBox(width: 5),
                                            productLoaded.discount == null
                                                ? Flexible(
                                                    child: Text(
                                                        "Rp ${productLoaded.price.toRupiah()}",
                                                        style: WHITE_TEXT_STYLE
                                                            .copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontUI
                                                                    .WEIGHT_MEDIUM)))
                                                : Flexible(
                                                    child: Text(
                                                        "Rp ${productLoaded.discount!.toRupiah()}",
                                                        style: WHITE_TEXT_STYLE
                                                            .copyWith(
                                                                fontSize: 16,
                                                                fontWeight: FontUI
                                                                    .WEIGHT_MEDIUM)))
                                          ]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
