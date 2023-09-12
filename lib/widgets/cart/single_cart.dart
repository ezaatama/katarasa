import 'package:flutter/material.dart';
import 'package:katarasa/models/cart/all_cart_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';

class SingleCart extends StatelessWidget {
  SingleCart({super.key, required this.products});

  ProductCart products;

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StdImage(
                            imageUrl: products.image,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * .200,
                            height: MediaQuery.of(context).size.height * .100),
                      ],
                    ),
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
                        "Stok tersedia ${products.stockRemaining}",
                        textAlign: TextAlign.left,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontWeight: FontUI.WEIGHT_LIGHT),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "x${products.qty}",
                        textAlign: TextAlign.left,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontWeight: FontUI.WEIGHT_LIGHT),
                      ),
                      //
                    ],
                  ),
                ),
              ),
              _priceTag()
            ],
          ),
        ),
        // _promo(),
      ],
    );

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
