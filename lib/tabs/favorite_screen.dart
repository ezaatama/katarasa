import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/favorite_product.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text("Produk Favorite Kamu",
            style: BROWN_TEXT_STYLE.copyWith(
                fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
      ),
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: FavoriteProduct(),
        ),
      )),
    );
  }
}
