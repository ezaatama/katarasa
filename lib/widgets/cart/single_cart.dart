import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart/all_cart/all_cart_cubit.dart';
import 'package:katarasa/data/cart/item_cart/item_cart_cubit.dart';
import 'package:katarasa/models/cart/all_cart_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

class SingleCart extends StatelessWidget {
  SingleCart({
    super.key,
    required this.products,
  });

  final ProductCart products;

  Widget _priceTag() {
    Widget price = Text(
      products.priceCurrencyFormat,
      textAlign: TextAlign.left,
      maxLines: 1,
      style: const TextStyle(
          color: ColorUI.PRIMARY_GREEN, fontWeight: FontUI.WEIGHT_BOLD),
    );

    Widget discount = Container();

    if (products.isDiscount != false) {
      price = Text(
        products.priceCurrencyFormat,
        textAlign: TextAlign.left,
        maxLines: 1,
        style: const TextStyle(
          color: ColorUI.PRIMARY_GREEN,
          decoration: TextDecoration.lineThrough,
        ),
      );
      discount = Text(
        products.discount,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: const TextStyle(
          fontWeight: FontUI.WEIGHT_BOLD,
          color: Colors.red,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(4),
      child: products.isDiscount == false
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                price,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                discount,
                const SizedBox(height: 10),
                price,
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = StatefulBuilder(builder: (context, setStater) {
      return Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ItemCartCubit, ItemCartState>(
                        builder: (context, state) {
                      return GestureDetector(
                          onTap: () {
                            setStater(() {
                              products.isSelected = !products.isSelected;

                              if (products.isSelected == true) {
                                context
                                    .read<ItemCartCubit>()
                                    .setSelectItem(context, products.cartId);
                              } else if (products.isSelected == false) {
                                context
                                    .read<ItemCartCubit>()
                                    .setSelectItem(context, products.cartId);
                              }
                              context.read<AllCartCubit>().getAllCart(context);
                            });
                          },
                          child: products.isSelected
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * .050,
                                  height:
                                      MediaQuery.of(context).size.height * .025,
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorUI.PRIMARY_GREEN,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        .040,
                                    height: MediaQuery.of(context).size.height *
                                        .020,
                                    decoration: BoxDecoration(
                                        color: ColorUI.PRIMARY_GREEN,
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * .050,
                                  height:
                                      MediaQuery.of(context).size.height * .025,
                                  decoration: BoxDecoration(
                                      color: ColorUI.GREY.withOpacity(.30),
                                      borderRadius: BorderRadius.circular(5)),
                                ));
                    }),
                    const SizedBox(width: 15),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(BorderUI.RADIUS_CIRCULAR),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StdImage(
                                        imageUrl: products.image,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .200,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .100),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products.name,
                                  textAlign: TextAlign.left,
                                  style: BLACK_TEXT_STYLE.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontUI.WEIGHT_BOLD),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Stok tersedia ${products.stockRemaining}",
                                  textAlign: TextAlign.left,
                                  style: BLACK_TEXT_STYLE.copyWith(
                                      fontWeight: FontUI.WEIGHT_LIGHT),
                                ),
                                const SizedBox(height: 15),
                                //
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocConsumer<ItemCartCubit, ItemCartState>(
                              listener: (context, state) {
                            if (state is DeleteItemSuccess) {
                              showToast(
                                  text: state.deleteSuccess,
                                  state: ToastStates.SUCCESS);
                              Navigator.pushReplacementNamed(context, '/home');
                            } else if (state is DeleteItemError) {
                              showToast(
                                  text: state.deleteError,
                                  state: ToastStates.ERROR);
                            }
                          }, builder: (context, state) {
                            return IconButton(
                                onPressed: () {
                                  setStater(() {
                                    context
                                        .read<ItemCartCubit>()
                                        .deleteItemCart(
                                            context, products.cartId);
                                  });
                                },
                                iconSize: 28,
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                ),
                                color: Colors.red);
                          }),
                          Row(
                            children: [
                              products.qty == '1'
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          .060,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .030,
                                      decoration: BoxDecoration(
                                          color: ColorUI.BACKGROUND_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(Icons.remove,
                                          color: ColorUI.WHITE, size: 14),
                                    )
                                  : BlocBuilder<ItemCartCubit, ItemCartState>(
                                      builder: (context, state) {
                                      return InkWell(
                                        onTap: () {
                                          setStater(() {
                                            context
                                                .read<ItemCartCubit>()
                                                .decrementCartItem(
                                                    products.productId,
                                                    products.variantId,
                                                    int.parse(products.qty) - 1,
                                                    context);
                                            context
                                                .read<AllCartCubit>()
                                                .getAllCart(context);
                                          });
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .060,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .030,
                                          decoration: BoxDecoration(
                                              color: ColorUI.PRIMARY_GREEN,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Icon(Icons.remove,
                                              color: ColorUI.WHITE, size: 14),
                                        ),
                                      );
                                    }),
                              const SizedBox(width: 5),
                              Text(
                                products.qty,
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                              ),
                              const SizedBox(width: 5),
                              BlocBuilder<ItemCartCubit, ItemCartState>(
                                  builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    setStater(() {
                                      context
                                          .read<ItemCartCubit>()
                                          .incrementCartItem(
                                              products.productId,
                                              products.variantId,
                                              int.parse(products.qty) + 1,
                                              context);
                                      context
                                          .read<AllCartCubit>()
                                          .getAllCart(context);
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        .060,
                                    height: MediaQuery.of(context).size.height *
                                        .030,
                                    decoration: BoxDecoration(
                                        color: ColorUI.PRIMARY_GREEN,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Icon(Icons.add,
                                        color: ColorUI.WHITE, size: 14),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                      //harga
                      _priceTag()
                    ],
                  ),
                )
              ],
            ),
          ),
          // _promo(),
        ],
      );
    });

    return InkWell(
      onTap: () {},
      child: content,
    );
  }
}
