import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart/all_cart/all_cart_cubit.dart';
import 'package:katarasa/data/cart/item_cart/item_cart_cubit.dart';
import 'package:katarasa/data/products/all_product/products_cubit.dart';
import 'package:katarasa/models/products/products_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:katarasa/widgets/product.dart';
import 'package:shimmer/shimmer.dart';

class SearchProduct extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<ProductsCubit>().getAllProduct(context, query: query);
    context.read<AllCartCubit>().getAllCart(context);

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return _shimmerContent(context);
        } else if (state is ProductsSuccess) {
          Map<String, List<ProductRequest>> mappedProduk = groupBy(
              state.allProduct, (ProductRequest produk) => produk.category);
          List<MapEntry<String, List<ProductRequest>>> prod =
              mappedProduk.entries.toList();
          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: prod.length,
                itemBuilder: (context, index) {
                  return _produkList(prod[index].value);
                }),
          );
        }

        return const SizedBox();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Search Product"),
    );
  }

  Widget _produkList(List<ProductRequest> prods) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: prods.length,
        itemBuilder: (context, index) {
          return Product(
            products: prods[index],
            addTocart: BlocConsumer<ItemCartCubit, ItemCartState>(
                listener: (context, state) {
              if (state is ItemCartUpdated) {
                showToast(text: state.cartUpdated, state: ToastStates.SUCCESS);
                Navigator.pushNamed(context, '/all-cart');
              } else if (state is ItemCartError) {
                showToast(text: state.errItemCart, state: ToastStates.ERROR);
              }
            }, builder: (context, state) {
              return InkWell(
                onTap: () {
                  context
                      .read<ItemCartCubit>()
                      .addToCartHome(prods[index].id, "", "1", context);
                },
                child: Image.asset("assets/icons/icon_add.png",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * .070,
                    height: MediaQuery.of(context).size.height * .035),
              );
            }),
          );
        });
  }

  Widget _shimmerContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
        baseColor: ColorUI.SHIMMER_BASE,
        highlightColor: ColorUI.SHIMMER_HIGHLIGHT,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}
