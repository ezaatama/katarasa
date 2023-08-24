import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class CustomizeOptional extends StatelessWidget {
  const CustomizeOptional({super.key, required this.tittle});

  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              tittle,
              style: const TextStyle(
                fontFamily: 'FredokaOne',
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Row(
              children: [
                Text('(optional)'),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          constraints: const BoxConstraints(maxHeight: 200),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorUI.WHITE,
            border: Border.all(
              color: ColorUI.LIGHT_BROWN,
              width: 1.0,
            ),
          ),
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 5,
                ),
                child: TextField(
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  showCursor: true,
                  cursorColor: ColorUI.LIGHT_BROWN,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
