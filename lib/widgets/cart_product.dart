import 'package:flutter/material.dart';
import 'package:katarasa/models/cart_models.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem(
      {super.key,
      required this.product,
      required this.decrementItem,
      required this.quantityItem,
      required this.incrementItem});

  final CartItem product;
  final Function() decrementItem;
  final String quantityItem;
  final Function() incrementItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
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
                product.product.discount == null
                    ? Text(
                        'Rp ${product.product.price.toRupiah()}',
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontWeight: FontUI.WEIGHT_LIGHT),
                      )
                    : Text(
                        'Rp ${product.product.discount!.toRupiah()}',
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontWeight: FontUI.WEIGHT_LIGHT),
                      )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              quantityItem == '1'
                  ? CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorUI.BACKGROUND_COLOR,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove,
                              color: ColorUI.WHITE, size: 20)),
                    )
                  : CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorUI.MEDIUM_BROWN,
                      child: IconButton(
                          onPressed: decrementItem,
                          icon: const Icon(Icons.remove,
                              color: ColorUI.WHITE, size: 20)),
                    ),
              const SizedBox(width: 5),
              Text(
                quantityItem,
                style: BLACK_TEXT_STYLE.copyWith(
                    fontSize: 20, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(width: 5),
              CircleAvatar(
                radius: 20,
                backgroundColor: ColorUI.MEDIUM_BROWN,
                child: IconButton(
                    onPressed: incrementItem,
                    icon:
                        const Icon(Icons.add, color: ColorUI.WHITE, size: 20)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
