import 'package:flutter/material.dart';
import 'package:katarasa/models/products/products_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';

class Product extends StatelessWidget {
  // final ProductModels products;
  final ProductRequest products;

  const Product({
    Key? key,
    required this.products,
  }) : super(key: key);

  Widget _priceTag() {
    Widget price = Text(
      products.price,
      textAlign: TextAlign.left,
      maxLines: 1,
      style:
          const TextStyle(color: ColorUI.BLACK, fontWeight: FontUI.WEIGHT_BOLD),
    );

    Widget discount = Container();

    if (products.isDiscount != false) {
      price = Text(
        products.price,
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

  // Widget _promo() {
  //   if (products.discount == null) return Container();

  //   return Column(
  //     children: [
  //       Container(
  //         // margin: EdgeInsets.all(8),
  //         padding: const EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //           color: ColorUI.WHITE,
  //           borderRadius: const BorderRadius.only(
  //             topLeft: Radius.circular(
  //               10,
  //             ),
  //             topRight: Radius.circular(
  //               BorderUI.RADIUS_ROUNDED,
  //             ),
  //             bottomRight: Radius.circular(
  //               BorderUI.RADIUS_ROUNDED,
  //             ),
  //           ),
  //           gradient: gradientColor(),
  //         ),
  //         child: const Text(
  //           "Promo",
  //           maxLines: 2,
  //           style: TextStyle(
  //             color: ColorUI.WHITE,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Widget content = Stack(
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
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 24, color: Colors.yellow),
                            Text(
                              products.rating,
                              style: BLACK_TEXT_STYLE.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                            )
                          ],
                        )
                      ],
                    ),
                    // Image.asset(
                    //   products.image,
                    //   fit: BoxFit.cover,
                    //   width: MediaQuery.of(context).size.width * .200,
                    // ),
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
                        products.location,
                        textAlign: TextAlign.left,
                        style: BLACK_TEXT_STYLE.copyWith(
                            color: ColorUI.BLACK.withOpacity(.60),
                            fontWeight: FontUI.WEIGHT_LIGHT),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      products.freeOngkir == 'Y'
                          ? Row(
                              children: [
                                Image.asset("assets/icons/free-delivery.png",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width *
                                        .050,
                                    height: MediaQuery.of(context).size.height *
                                        .025),
                                const SizedBox(width: 7),
                                Text(
                                  "Free Ongkir",
                                  textAlign: TextAlign.left,
                                  style: BLACK_TEXT_STYLE.copyWith(
                                      color: ColorUI.BLACK.withOpacity(.60),
                                      fontWeight: FontUI.WEIGHT_LIGHT),
                                  maxLines: 2,
                                )
                              ],
                            )
                          : const SizedBox()

                      // Text(
                      //   products.title,
                      //   textAlign: TextAlign.left,
                      //   style: BLACK_TEXT_STYLE.copyWith(
                      //       fontWeight: FontUI.WEIGHT_BOLD),
                      //   maxLines: 2,
                      // ),
                      // const SizedBox(height: 5),
                      // Text(
                      //   products.ingredient,
                      //   textAlign: TextAlign.left,
                      //   style: BLACK_TEXT_STYLE.copyWith(
                      //       color: ColorUI.BLACK.withOpacity(.60),
                      //       fontWeight: FontUI.WEIGHT_LIGHT),
                      //   maxLines: 2,
                      // ),
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
        Navigator.pushNamed(context, '/product-detail',
            arguments: products.slug);
        debugPrint("ini product slug nya => ${products.slug}");
      },
      child: content,
    );
  }
}
