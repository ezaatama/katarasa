import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/card/card_all_order.dart';

class AllOrderScreen extends StatelessWidget {
  const AllOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                size: 24, color: ColorUI.BLACK),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Semua Pesanan",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [CardAllOrder()],
          ),
        ),
      )),
    );
  }
}
