import 'package:flutter/material.dart';
import 'package:katarasa/models/dummy/cart_models.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem(
      {super.key,
      required this.product,
      required this.decrementItem,
      required this.quantityItem,
      required this.incrementItem,
      required this.clearItem});

  final CartItem product;
  final Function() decrementItem;
  final String quantityItem;
  final Function() incrementItem;
  final Function() clearItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  product.product.image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * .200,
                  height: MediaQuery.of(context).size.height * .100,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.product.title,
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontSize: 18, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                    ),
                    Text(
                      product.product.ingredient,
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontSize: 14, fontWeight: FontUI.WEIGHT_LIGHT),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  product.product.discount == null
                      ? Text(
                          'Rp ${product.product.price.toRupiah()}',
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontSize: 16, fontWeight: FontUI.WEIGHT_LIGHT),
                        )
                      : Text(
                          'Rp ${product.product.discount!.toRupiah()}',
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontSize: 16, fontWeight: FontUI.WEIGHT_LIGHT),
                        ),
                  const SizedBox(height: 5),
                  Text(
                    "x$quantityItem",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontSize: 16, fontWeight: FontUI.WEIGHT_MEDIUM),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      InkWell(
                        onTap: clearItem,
                        child: Image.asset("assets/icons/trash.png",
                            width: 25, height: 25),
                      ),
                      const SizedBox(width: 10),
                      quantityItem == '1'
                          ? CircleAvatar(
                              radius: 15,
                              backgroundColor: ColorUI.BACKGROUND_COLOR,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove,
                                      color: ColorUI.WHITE, size: 10)),
                            )
                          : CircleAvatar(
                              radius: 15,
                              backgroundColor: ColorUI.MEDIUM_BROWN,
                              child: IconButton(
                                  onPressed: decrementItem,
                                  icon: const Icon(Icons.remove,
                                      color: ColorUI.WHITE, size: 10)),
                            ),
                      const SizedBox(width: 5),
                      Text(
                        quantityItem,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontSize: 20, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                      ),
                      const SizedBox(width: 5),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: ColorUI.MEDIUM_BROWN,
                        child: IconButton(
                            onPressed: incrementItem,
                            icon: const Icon(Icons.add,
                                color: ColorUI.WHITE, size: 10)),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
