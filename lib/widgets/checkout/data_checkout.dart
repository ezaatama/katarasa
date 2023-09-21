import 'package:flutter/material.dart';
import 'package:katarasa/models/checkout/checkout_request.dart';
import 'package:katarasa/utils/constant.dart';

class DataCheckout extends StatelessWidget {
  const DataCheckout({super.key, required this.cartCheckout});

  final Cart cartCheckout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Image.network(cartCheckout.store.image),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                cartCheckout.store.name,
                style: BLACK_TEXT_STYLE.copyWith(
                    fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
            )
          ],
        )
      ],
    );
  }
}
