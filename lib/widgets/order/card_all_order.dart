import 'package:flutter/material.dart';
import 'package:katarasa/models/order/order_request.dart';
import 'package:katarasa/utils/constant.dart';

class CardAllOrder extends StatelessWidget {
  const CardAllOrder(
      {super.key,
      required this.item,
      required this.invoice,
      required this.store,
      required this.productName,
      required this.productSubTotal});

  final DataItem item;
  final ItemItem invoice;
  final ItemItem store;
  final Product productName;
  final DataItem productSubTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Id",
                style:
                    BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
              ),
              Text(
                item.orderId,
                style:
                    BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "No. Invoice",
                style:
                    BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
              ),
              Text(
                invoice.invoice,
                style:
                    BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 2, height: 3),
          const SizedBox(height: 5),
          Text(
            "${store.store.name} - ${store.store.location}",
            style: BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
          ),
          const SizedBox(height: 3),
          Text(
            productName.name,
            style: BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 2, height: 3),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              Text(
                item.totalPriceCurrencyFormat,
                style: RED_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
