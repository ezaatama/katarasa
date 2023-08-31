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
          color: ColorUI.BLACK,
          decoration: TextDecoration.lineThrough,
        ),
      );
      discount = Text(
        "Rp ${products.discount!.toRupiah()}",
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
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              // decoration: BoxDecoration(
              //   color: ColorUI.WHITE,
              //   boxShadow: containerShadow(
              //     spreadRadius: 0.1,
              //     blurRadius: 5,
              //     offset: const Offset(0, 1),
              //   ),
              //   borderRadius: const BorderRadius.all(
              //     Radius.circular(
              //       BorderUI.RADIUS_CIRCULAR,
              //     ),
              //   ),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(BorderUI.RADIUS_CIRCULAR),
                    child: Stack(
                      children: [
                        // StdImage(
                        //   imageUrl: products.image,
                        // ),
                        Image.asset(
                          products.image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * .200,
                        ),
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
                              fontWeight: FontUI.WEIGHT_BOLD),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 5),
                        _priceTag(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _promo(),
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
