import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart_item/cart_item_cubit.dart';
import 'package:katarasa/data/product/product_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  // ignore: unused_field
  Widget? _text;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProduct();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _text = _isSliverAppBarExpanded
              ? const Text("KataRasa Coffee")
              : const Text("KataRasa Coffeesss");
        });
      });
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > 300 - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorUI.LIGHT_BROWN,
            expandedHeight: 300,
            toolbarHeight: 70,
            pinned: true,
            snap: false,
            floating: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: ColorUI.WHITE,
                            borderRadius: BorderRadius.circular(50)),
                        child: Image.asset("assets/images/iconkeranjang.png",
                            width: 30, height: 30),
                      ),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: BlocBuilder<CartItemCubit, CartItemState>(
                                  builder: (context, state) {
                                if (state is CartItemUpdated) {
                                  return Text(
                                      state.cartItems.isEmpty
                                          ? "0"
                                          : state.cartItems.length.toString(),
                                      style: WHITE_TEXT_STYLE.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontUI.WEIGHT_SEMI_BOLD));
                                }
                                return const SizedBox();
                              }),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              title: _isSliverAppBarExpanded
                  ? Text(
                      "KataRasa Coffee",
                      style: BROWN_TEXT_STYLE.copyWith(fontSize: 26),
                    )
                  : null,
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            const Color(0xFF414042).withOpacity(0.15),
                            BlendMode.dstATop),
                        image: const AssetImage(
                          'assets/images/bgAtas.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset("assets/images/logokatarasa.png",
                              width: double.maxFinite, fit: BoxFit.contain),
                        ),
                      ],
                    )),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 25.0, right: 10.0, bottom: 20.0),
                    child: const Text(
                      "Coffee",
                      style: TextStyle(
                        color: ColorUI.BLACK,
                        fontSize: 15,
                        fontFamily: 'FredokaOne',
                      ),
                    ),
                  ),
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductSuccess) {
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(5.0),
                            itemCount: state.product.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / 1.3,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) {
                              return Product(products: state.product[index]);
                            });
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}
