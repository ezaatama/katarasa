import 'package:flutter/material.dart';
import 'package:katarasa/models/order/detail_order_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/general/image.dart';
import 'package:timelines/timelines.dart';

class CardDetailOrder extends StatelessWidget {
  const CardDetailOrder(
      {super.key,
      required this.detail,
      required this.detailItem,
      required this.detailProduct,
      required this.detailHistory});

  final DetailOrder detail;
  final Item detailItem;
  final Product detailProduct;
  final Widget detailHistory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.120,
            margin: const EdgeInsets.only(bottom: 15),
            child: detailHistory),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ColorUI.GREY.withOpacity(.20),
                offset: const Offset(
                  0.0,
                  2.0,
                ),
                blurRadius: 12.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              const BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Status Pesanan",
                        textAlign: TextAlign.center,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: parseStatusBg(detail.status),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        parseStatusCaption(detail.statusTitle),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: parseStatusTx(detail.status),
                          fontWeight: FontUI.WEIGHT_MEDIUM,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Divider(
                thickness: 2,
                height: 3,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Id",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_LIGHT)),
                  Text(detail.orderId,
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No. Invoice",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_LIGHT)),
                  Text(detailItem.invoice,
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(
                thickness: 2,
                height: 3,
              ),
              const SizedBox(height: 10),
              //column product
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StdImage(
                          imageUrl: detailProduct.image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * .200,
                          height: MediaQuery.of(context).size.height * .100),
                      const SizedBox(width: 10),
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detailProduct.name,
                            style: BLACK_TEXT_STYLE.copyWith(
                                fontSize: 18,
                                fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            detailProduct.description,
                            style: BLACK_TEXT_STYLE.copyWith(
                                fontSize: 12, fontWeight: FontUI.WEIGHT_LIGHT),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${detailProduct.qty} item",
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_LIGHT),
                              ),
                              detailProduct.isDiscount == false
                                  ? Flexible(
                                      child: Text(
                                        detailProduct.priceCurrencyFormat,
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight:
                                                FontUI.WEIGHT_SEMI_BOLD),
                                      ),
                                    )
                                  : Flexible(
                                      child: Column(
                                        children: [
                                          Text(
                                            detailProduct
                                                .priceDiscountCurrencyFormat,
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_SEMI_BOLD),
                                          ),
                                          Text(
                                            detailProduct.priceCurrencyFormat,
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight:
                                                    FontUI.WEIGHT_LIGHT),
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              //column store
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Toko",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                  const SizedBox(height: 5),
                  Text(detailItem.store.name,
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_LIGHT)),
                  const SizedBox(height: 3),
                  Text(detailItem.store.fullLocation.address,
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_LIGHT)),
                ],
              ),
              const SizedBox(height: 10),
              //column address
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Alamat pengiriman",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Penerima",
                              style: BLACK_TEXT_STYLE.copyWith(
                                  fontWeight: FontUI.WEIGHT_LIGHT)),
                          Text(detailItem.address.receiverName,
                              textAlign: TextAlign.end,
                              style: BLACK_TEXT_STYLE.copyWith(
                                  fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Nomor HP",
                              style: BLACK_TEXT_STYLE.copyWith(
                                  fontWeight: FontUI.WEIGHT_LIGHT)),
                          Text(detailItem.address.phoneNumber,
                              textAlign: TextAlign.end,
                              style: BLACK_TEXT_STYLE.copyWith(
                                  fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text("Alamat lengkap",
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_LIGHT)),
                          ),
                          Flexible(
                            child: Text(detailItem.address.address,
                                textAlign: TextAlign.justify,
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //column shipping
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pengiriman menggunakan",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(detailItem.shippingSelected.name,
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_LIGHT)),
                            Text(detailItem.shippingSelected.description,
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_LIGHT)),
                            Text(
                                "Estimasi pengiriman ${detailItem.shippingSelected.etdText}",
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_LIGHT)),
                            Text("Berat produk ${detailItem.totalWeight} gr",
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_LIGHT)),
                          ],
                        ),
                      ),
                      Text(detailItem.shippingSelected.priceCurrencyFormat,
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    ],
                  ),
                ],
              ),
              //total
              const SizedBox(height: 10),
              const Divider(
                thickness: 2,
                height: 3,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  ),
                  Text(
                    detail.totalCurrencyFormat,
                    style: RED_TEXT_STYLE.copyWith(
                        fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        detail.status == 'notPaid'
            ? PrimaryButton(
                text: "Bayar Pesanan",
                onPressed: () {
                  Navigator.pushNamed(context, '/payment',
                      arguments: detail.orderId);
                })
            : const SizedBox()
      ],
    );
  }
}
