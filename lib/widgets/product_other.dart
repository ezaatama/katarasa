import 'package:flutter/material.dart';
import 'package:katarasa/models/products/product_detail_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';

class ProductOther extends StatelessWidget {
  final OtherProduct products;

  const ProductOther({
    Key? key,
    required this.products,
  }) : super(key: key);

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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
