import 'package:flutter/material.dart';
import 'package:katarasa/models/product_models.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/primary_button.dart';

class FavoriteProductItem extends StatelessWidget {
  final ProductModels products;

  const FavoriteProductItem({
    Key? key,
    required this.products,
  }) : super(key: key);

  Widget _priceTag() {
    Widget price = Text(
      "Rp ${products.price.toString()}",
      textAlign: TextAlign.left,
      maxLines: 1,
      style: const TextStyle(
        color: ColorUI.BLACK,
      ),
    );

    Widget discount = Container();

    if (products.discount != null) {
      price = Text(
        "Rp ${products.price.toRupiah()}",
        textAlign: TextAlign.left,
        maxLines: 1,
        style: const TextStyle(
          color: ColorUI.GREY,
          decoration: TextDecoration.lineThrough,
        ),
      );
      discount = Text(
        "Rp ${products.discount!.toRupiah()}",
        textAlign: TextAlign.center,
        maxLines: 1,
        style: const TextStyle(
          fontWeight: FontUI.WEIGHT_SEMI_BOLD,
          color: Colors.red,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          price,
          const SizedBox(height: 10),
          discount,
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
    Widget content = Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      decoration: BoxDecoration(
        color: ColorUI.WHITE,
        boxShadow: containerShadow(
          spreadRadius: 0.1,
          blurRadius: 5,
          offset: const Offset(0, 1),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            BorderUI.RADIUS_CIRCULAR,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(
                BorderUI.RADIUS_CIRCULAR,
              ),
            ),
            child: Stack(
              children: [
                // StdImage(
                //   imageUrl: products.image,
                // ),
                Image.asset(
                  products.image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                _promo(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(4, 10, 4, 0),
            child: Text(
              products.title,
              textAlign: TextAlign.left,
              style: BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_BOLD),
              maxLines: 2,
            ),
          ),
          _priceTag(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PrimaryButton(
                  text: 'Beli Sekarang',
                  onPressed: () {
                    debugPrint("beli sekarang");
                  })
            ],
          )
        ],
      ),
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
