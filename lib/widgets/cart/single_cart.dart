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
    // required this.decrementItem,
    // required this.incrementItem,
    // required this.quantityItem
  });

  final ProductCart products;
  // final Function() decrementItem;
  // final Function() incrementItem;
  // final String quantityItem;

  Widget _priceTag() {
    Widget price = Text(
      products.priceCurrencyFormat,
      textAlign: TextAlign.left,
      maxLines: 1,
      style:
          const TextStyle(color: ColorUI.BLACK, fontWeight: FontUI.WEIGHT_BOLD),
    );

    Widget discount = Container();

    if (products.isDiscount != false) {
      price = Text(
        products.priceCurrencyFormat,
        textAlign: TextAlign.left,
        maxLines: 1,
        style: const TextStyle(
          color: ColorUI.BLACK,
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
                const SizedBox(height: 5),
                Text(
                  "x${products.qty}",
                  textAlign: TextAlign.left,
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontWeight: FontUI.WEIGHT_LIGHT),
                ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ItemCartCubit, ItemCartState>(
                        builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          setStater(() {
                            products.isSelected = !products.isSelected;
                            // if (products.isSelected == true) {
                            //   context
                            //       .read<ItemCartCubit>()
                            //       .setSelectItem(context, products.cartId);
                            //   debugPrint(
                            //       "ini products selected harusnya true : ${products.isSelected}");
                            // } else if (products.isSelected == false) {
                            //   context
                            //       .read<ItemCartCubit>()
                            //       .setSelectItem(context, products.cartId);
                            //   debugPrint(
                            //       "ini products selected harusnya false : ${products.isSelected}");
                            // }
                          });
                        },
                        child: products.isSelected
                            ? const Icon(Icons.check_circle,
                                size: 25, color: ColorUI.BROWN)
                            : Icon(Icons.check_circle_outline,
                                size: 25, color: ColorUI.GREY.withOpacity(.40)),
                      );
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
                    _priceTag(),
                  ],
                ),
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
                            text: state.deleteError, state: ToastStates.ERROR);
                      }
                    }, builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            setStater(() {
                              context
                                  .read<ItemCartCubit>()
                                  .deleteItemCart(context, products.cartId);
                            });
                          },
                          iconSize: 28,
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                          ),
                          color: ColorUI.BROWN);
                    }),
                    Row(
                      children: [
                        products.qty == '1'
                            ? CircleAvatar(
                                radius: 13,
                                backgroundColor: ColorUI.BACKGROUND_COLOR,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove,
                                        color: ColorUI.WHITE, size: 10)),
                              )
                            : BlocBuilder<ItemCartCubit, ItemCartState>(
                                builder: (context, state) {
                                return CircleAvatar(
                                  radius: 13,
                                  backgroundColor: ColorUI.MEDIUM_BROWN,
                                  child: IconButton(
                                      onPressed: () {
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
                                      icon: const Icon(Icons.remove,
                                          color: ColorUI.WHITE, size: 10)),
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
                          return CircleAvatar(
                            radius: 13,
                            backgroundColor: ColorUI.MEDIUM_BROWN,
                            child: IconButton(
                                onPressed: () {
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
                                icon: const Icon(Icons.add,
                                    color: ColorUI.WHITE, size: 10)),
                          );
                        }),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          // _promo(),
        ],
      );
    });

    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/product-detail',
        //     arguments: products.slug);
        // debugPrint("ini product slug nya => ${products.slug}");
      },
      child: content,
    );
  }
}
