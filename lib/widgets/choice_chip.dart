import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class CategoryType extends StatelessWidget {
  const CategoryType(
      {super.key,
      required this.title,
      required this.selected,
      required this.cb});

  final String title;
  final bool selected;
  final VoidCallback cb;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: cb,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: selected ? ColorUI.CATEGORY_BG : ColorUI.WHITE,
            border: selected ? null : Border.all(color: ColorUI.BLACK),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                BorderUI.RADIUS_ROUNDED,
              ),
            ),
            // gradient: selected ? gradientColor() : null,
          ),
          child: Text(
            title,
            maxLines: 2,
            style: TextStyle(
              color: selected ? ColorUI.WHITE : ColorUI.BLACK,
            ),
          ),
        ),
      ),
    );
  }
}
