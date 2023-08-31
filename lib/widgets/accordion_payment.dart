// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:katarasa/models/dummy/cart_models.dart';
import 'package:katarasa/utils/constant.dart';

class AccordionPayment extends StatelessWidget {
  AccordionPayment(
      {super.key,
      required this.value,
      required this.groupValue,
      this.onChanged,
      required this.text,
      required this.image});

  String value;
  String groupValue;
  void Function(dynamic)? onChanged;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setStater) {
      bool selected = value != groupValue;
      bool noSelected = value == groupValue;
      return GestureDetector(
        onTap: () {
          setStater(() {
            if (selected) {
              onChanged!(value);
              Navigator.pop(context, value);
            } else if (noSelected) {
              onChanged!(value);
              Navigator.pop(context, value);
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.transparent),
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * .100,
                height: MediaQuery.of(context).size.height * .040,
              ),
              const SizedBox(width: 10),
              Text(text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                      color: Color(0xFF4F4F4F))),
              const Spacer(),
              value == groupValue
                  ? Image.asset("assets/icons/icon_radio_blue.png",
                      width: 18, height: 18)
                  : Image.asset("assets/icons/icon_radio_white.png",
                      width: 18, height: 18)
            ],
          ),
        ),
      );
    });
  }
}
