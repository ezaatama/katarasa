import 'package:flutter/material.dart';
import 'package:katarasa/models/checkout/shipping_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';

class CustomTimeShipping extends StatefulWidget {
  CustomTimeShipping(
      {super.key,
      required this.value,
      required this.groupValue,
      this.onChanged,
      required this.time});

  String value;
  String groupValue;
  void Function(dynamic)? onChanged;
  final SendTime time;

  @override
  State<CustomTimeShipping> createState() => CustomTimeShippingState();
}

class CustomTimeShippingState extends State<CustomTimeShipping> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setStater) {
      bool selected = widget.value != widget.groupValue;
      bool noSelected = widget.value == widget.groupValue;
      return GestureDetector(
        onTap: () {
          setStater(() {
            if (selected) {
              widget.onChanged!(widget.value);
            } else if (noSelected) {
              widget.onChanged!(widget.value);
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 15, bottom: 15),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: widget.value == widget.groupValue
                    ? ColorUI.BROWN.withOpacity(0.20)
                    : Colors.transparent,
                border: Border.all(
                    width: 1.0,
                    color: widget.value == widget.groupValue
                        ? ColorUI.BROWN
                        : ColorUI.BROWN.withOpacity(0.10)),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(widget.time.name,
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontSize: 14,
                        fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                        color: ColorUI.BLACK.withOpacity(0.70))),
              )),
        ),
      );
    });
  }
}
