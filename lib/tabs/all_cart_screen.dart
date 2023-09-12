import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart/all_cart/all_cart_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/cart/single_cart.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';

class AllCartScreen extends StatefulWidget {
  const AllCartScreen({super.key});

  @override
  State<AllCartScreen> createState() => _AllCartScreenState();
}

class _AllCartScreenState extends State<AllCartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AllCartCubit>().getAllCart(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Keranjang Anda",
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
            children: [
              BlocBuilder<AllCartCubit, AllCartState>(
                builder: (context, state) {
                  if (state is AllCartLoading) {
                    return const LoaderIndicator();
                  } else if (state is AllCartLoaded) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.allCartLoaded.items.length,
                        itemBuilder: (context, index) {
                          return SingleCart(
                              products: state
                                  .allCartLoaded.items[index].products[index]);
                        });
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
