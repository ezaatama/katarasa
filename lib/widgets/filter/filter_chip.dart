import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class ChipFilterStatus extends StatelessWidget {
  ChipFilterStatus(
      {super.key,
      this.filter,
      required this.value,
      required this.groupValue,
      this.onChanged});

  String value;
  String groupValue;
  void Function(String?)? onChanged;
  final String? filter;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setStater) {
      bool selected = value != groupValue;
      return GestureDetector(
        onTap: () {
          setStater(() {
            if (selected) {
              onChanged!(value);
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: BoxDecoration(
            color: value == groupValue
                ? const Color(0xFFE4EAFF)
                : Colors.transparent,
            border: Border.all(
                width: 1.0,
                color: value == groupValue
                    ? ColorUI.PRIMARY_GREEN
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(filter!,
              textAlign: TextAlign.center,
              style: BLACK_TEXT_STYLE.copyWith(
                  fontSize: 11, fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
        ),
      );
    });
  }
}
