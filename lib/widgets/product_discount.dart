import 'package:flutter/material.dart';
import 'package:katarasa/models/dummy/product_models.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';

class ProductDiscount extends StatelessWidget {
  final ProductModels products;

  const ProductDiscount({
    Key? key,
    required this.products,
  }) : super(key: key);

  Widget _priceTag() {
    Widget price = Text(
      "Rp ${products.price.toRupiah()}",
      textAlign: TextAlign.left,
      maxLines: 1,
      style:
          const TextStyle(color: ColorUI.BLACK, fontWeight: FontUI.WEIGHT_BOLD),
    );

    Widget discount = Container();

    if (products.discount != null) {
      price = Text(
        "Rp ${products.price.toRupiah()}",
        textAlign: TextAlign.left,
        maxLines: 1,
        style: const TextStyle(
            fontSize: 16, color: ColorUI.BLACK, fontWeight: FontUI.WEIGHT_BOLD),
      );
      discount = Text(
        "Rp ${products.discount!.toRupiah()}",
        textAlign: TextAlign.center,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontUI.WEIGHT_BOLD,
          color: Colors.red,
          decoration: TextDecoration.lineThrough,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(4),
      child: products.discount == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                price,
                discount,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                discount,
                price,
              ],
            ),
    );
  }

  Widget _promo() {
    if (products.discount == null) return Container();

    return Column(
      children: [
        Container(
          // margin: EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorUI.WHITE,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                10,
              ),
              topRight: Radius.circular(
                BorderUI.RADIUS_ROUNDED,
              ),
              bottomRight: Radius.circular(
                BorderUI.RADIUS_ROUNDED,
              ),
            ),
            gradient: gradientColor(),
          ),
          child: const Text(
            "Promo",
            maxLines: 2,
            style: TextStyle(
              color: ColorUI.WHITE,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(0, 4, 20, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(BorderUI.RADIUS_CIRCULAR),
                    child: Stack(
                      children: [
                        Image.asset(
                          products.image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * .300,
                        ),
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
                                  "${products.star}/5",
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products.title,
                          textAlign: TextAlign.left,
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontSize: 18, fontWeight: FontUI.WEIGHT_BOLD),
                          maxLines: 2,
                        ),
                        Text(
                          products.subtitle,
                          textAlign: TextAlign.left,
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontSize: 12, fontWeight: FontUI.WEIGHT_LIGHT),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 3),
                        _priceTag(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // _promo(),
          ],
        ),
      ],
    );

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail-product', arguments: products.id);
        debugPrint("ini product id nya => ${products.id}");
      },
      child: content,
    );
  }
}
