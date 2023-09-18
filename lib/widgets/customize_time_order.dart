// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class CustomTimeOrder extends StatelessWidget {
  CustomTimeOrder(
      {Key? key,
      required this.value,
      required this.groupValue,
      this.onChanged,
      required this.text,
      required this.title})
      : super(key: key);

  String value;
  String groupValue;
  void Function(dynamic)? onChanged;
  final String text;
  final String title;

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
            } else if (noSelected) {
              onChanged!(value);
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.transparent),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                          color: Color(0xFF4F4F4F))),
                  Text(text,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontUI.WEIGHT_LIGHT,
                          color: Color(0xFF4F4F4F))),
                ],
              ),
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
