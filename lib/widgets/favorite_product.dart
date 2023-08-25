import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/product/product_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/favorite_product_item.dart';

class FavoriteProduct extends StatefulWidget {
  const FavoriteProduct({super.key});

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductCubit>().favoriteProduct();
    return products.isNotEmpty
        ? SizedBox(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(5.0),
                itemCount: products.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.35,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return FavoriteProductItem(products: products[index]);
                }),
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/like_product.png", fit: BoxFit.cover),
                Text(
                  "Kamu belum menambahkan produk favorite",
                  textAlign: TextAlign.center,
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontSize: 20, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                )
              ],
            ),
          );
  }
}
