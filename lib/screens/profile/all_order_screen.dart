import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/order/all_order/data_order_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:shimmer/shimmer.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DataOrderCubit>().getAllOrder(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                _bodyContent(),
                Positioned(
                  height: 24.0,
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: connected
                      ? const SizedBox()
                      : Container(
                          color: const Color(0xFFEE4400),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Periksa Kembali Jaringan Anda",
                                    style: WHITE_TEXT_STYLE.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
          child: _bodyContent()),
    );
  }

  Widget _bodyContent() {
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
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: SingleChildScrollView(
          child: BlocBuilder<DataOrderCubit, DataOrderState>(
            builder: (context, state) {
              if (state is DataOrderLoading) {
                return _shimmerContent();
              } else if (state is DataOrderEmpty) {
                return const Center(child: Text("Data Order Kosong"));
              } else if (state is DataOrderLoaded) {
                return Column(
                    children: state.dataOrderLoaded.items.map((items) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/order-detail',
                          arguments: items.orderId);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: ColorUI.GREY.withOpacity(.20),
                            offset: const Offset(
                              0.0,
                              2.0,
                            ),
                            blurRadius: 12.0,
                            spreadRadius: 1.0,
                          ), //BoxShadow
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order Id",
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_MEDIUM),
                              ),
                              Text(
                                items.orderId,
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_MEDIUM),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Column(
                            children: items.items.map((inv) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "No. Invoice",
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        fontWeight: FontUI.WEIGHT_MEDIUM),
                                  ),
                                  Text(
                                    inv.invoice,
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        fontWeight: FontUI.WEIGHT_MEDIUM),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 5),
                          const Divider(thickness: 2, height: 3),
                          const SizedBox(height: 5),
                          Column(
                              children: items.items.map((store) {
                            return Text(
                              "${store.store.name} - ${store.store.location}",
                              style: BLACK_TEXT_STYLE.copyWith(
                                  fontWeight: FontUI.WEIGHT_MEDIUM),
                            );
                          }).toList()),
                          const SizedBox(height: 3),
                          Column(
                            children: items.items.map((prod) {
                              return Column(
                                  children: prod.products.map((singleProd) {
                                return Text(
                                  singleProd.name,
                                  style: BLACK_TEXT_STYLE.copyWith(
                                      fontWeight: FontUI.WEIGHT_MEDIUM),
                                );
                              }).toList());
                            }).toList(),
                          ),
                          const SizedBox(height: 5),
                          const Divider(thickness: 2, height: 3),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                              ),
                              Text(
                                items.totalPriceCurrencyFormat,
                                style: RED_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList());
              }
              return const SizedBox();
            },
          ),
        ),
      )),
    );
  }

  Widget _shimmerContent() {
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
