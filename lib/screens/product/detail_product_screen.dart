import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart/cart_cubit.dart';
import 'package:katarasa/data/cart_item/cart_item_cubit.dart';
import 'package:katarasa/data/product/product_cubit.dart';
import 'package:katarasa/models/been_models.dart';
import 'package:katarasa/models/cart_models.dart';
import 'package:katarasa/models/milk_models.dart';
import 'package:katarasa/models/product_models.dart';
import 'package:katarasa/models/temp_models.dart';
import 'package:katarasa/models/topping_models.dart';
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
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            ),
                            child: Image.asset(
                              productLoaded.image,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          const SizedBox(height: 5),
                          //title - description
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      productLoaded.title,
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontSize: 26,
                                          fontWeight: FontUI.WEIGHT_BOLD),
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          productLoaded.discount == null
                                              ? Text(
                                                  "Rp ${productLoaded.price.toRupiah()}",
                                                  style: RED_TEXT_STYLE.copyWith(
                                                      fontSize: 24,
                                                      fontWeight: FontUI
                                                          .WEIGHT_SEMI_BOLD),
                                                )
                                              : Column(children: [
                                                  Text(
                                                    "Rp ${productLoaded.price.toRupiah()}",
                                                    style: BLACK_TEXT_STYLE
                                                        .copyWith(
                                                            fontSize: 24,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontWeight: FontUI
                                                                .WEIGHT_LIGHT),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "Rp ${productLoaded.discount!.toRupiah()}",
                                                    style: RED_TEXT_STYLE.copyWith(
                                                        fontSize: 24,
                                                        fontWeight: FontUI
                                                            .WEIGHT_SEMI_BOLD),
                                                  ),
                                                ])
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  productLoaded.category,
                                  style: BROWN_TEXT_STYLE.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontUI.WEIGHT_MEDIUM),
                                ),
                                const SizedBox(height: 4),
                                const Divider(
                                  thickness: 2,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Been",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontSize: 18,
                                            fontWeight:
                                                FontUI.WEIGHT_SEMI_BOLD),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: beenPreferences.map((been) {
                                            return ChipProduct(
                                              filter: been.tittle,
                                              value: been.tittle,
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
                                        "Temperatur/Size",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontSize: 18,
                                            fontWeight:
                                                FontUI.WEIGHT_SEMI_BOLD),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: tempSizes.map((temp) {
                                            return ChipProduct(
                                              filter: temp.tittle,
                                              value: temp.tittle,
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
                                        "Topping",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontSize: 18,
                                            fontWeight:
                                                FontUI.WEIGHT_SEMI_BOLD),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: topping.map((topping) {
                                            return ChipProduct(
                                              filter: topping.tittle,
                                              value: topping.tittle,
                                              groupValue: hasTopping,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  hasTopping = value!;
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
                                        "Milk",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontSize: 18,
                                            fontWeight:
                                                FontUI.WEIGHT_SEMI_BOLD),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: milk.map((milk) {
                                            return ChipProduct(
                                              filter: milk.tittle,
                                              value: milk.tittle,
                                              groupValue: hasMilk,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  hasMilk = value!;
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                CustomizeOptional(tittle: 'Description'),
                              ],
                            ),
                          )
                        ],
                      ),
                      SafeArea(
                          child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorUI.WHITE,
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  },
                                  icon: const Icon(Icons.arrow_back_outlined),
                                  color: ColorUI.BLACK),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorUI.WHITE,
                                  borderRadius: BorderRadius.circular(50)),
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
          );
        }
        return const SizedBox();
      },
    );
  }
}
