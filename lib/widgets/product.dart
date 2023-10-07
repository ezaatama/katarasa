import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart/item_cart/item_cart_cubit.dart';
import 'package:katarasa/models/products/products_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

class Product extends StatelessWidget {
  // final ProductModels products;
  final ProductRequest products;
  final Widget addTocart;

  const Product({Key? key, required this.products, required this.addTocart})
      : super(key: key);

  Widget _priceTag() {
    Widget price = Text(
      products.price,
      textAlign: TextAlign.left,
      maxLines: 1,
      style: const TextStyle(
          fontSize: 18, color: ColorUI.BLACK, fontWeight: FontUI.WEIGHT_BOLD),
    );

    Widget discount = Container();

    if (products.isDiscount != false) {
      price = Text(
        products.price,
        textAlign: TextAlign.left,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 18,
          color: ColorUI.BLACK,
          decoration: TextDecoration.lineThrough,
        ),
      );
      discount = Text(
        products.discount,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontUI.WEIGHT_BOLD,
          color: Colors.red,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(4),
      child: products.isDiscount == false
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                price,
                const SizedBox(height: 10),
                discount,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
    Widget content = Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(BorderUI.RADIUS_CIRCULAR),
                child: Stack(
                  children: [
                    StdImage(
                        imageUrl: products.image,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * .250,
                        height: MediaQuery.of(context).size.height * .130),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: ColorUI.WHITE,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text(
                              "${products.rating}/5",
                              style: BLACK_TEXT_STYLE.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products.name,
                        textAlign: TextAlign.left,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontSize: 18, fontWeight: FontUI.WEIGHT_BOLD),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        products.category,
                        textAlign: TextAlign.left,
                        style: BLACK_TEXT_STYLE.copyWith(
                            color: ColorUI.BLACK.withOpacity(.60),
                            fontWeight: FontUI.WEIGHT_LIGHT),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      products.freeOngkir == 'Y'
                          ? Text(
                              "Free Ongkir",
                              textAlign: TextAlign.left,
                              style: BLACK_TEXT_STYLE.copyWith(
                                  color: ColorUI.PRIMARY_GREEN.withOpacity(.60),
                                  fontWeight: FontUI.WEIGHT_LIGHT),
                              maxLines: 2,
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [_priceTag(), addTocart],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // _promo(),
      ],
    );

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product-detail',
            arguments: products.slug);
        debugPrint("ini product slug nya => ${products.slug}");
      },
      child: content,
    );
  }
}
