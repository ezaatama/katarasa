import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/order/all_order/data_order_cubit.dart';
import 'package:katarasa/models/filter/filter_status.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/filter/filter_chip.dart';
import 'package:katarasa/widgets/general/make_dismiss.dart';
import 'package:shimmer/shimmer.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  String hasFilter = 'notPaid';

  @override
  void initState() {
    super.initState();
    context.read<DataOrderCubit>().getAllOrder(context, hasFilter);
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
          title: Text(
            "Semua Pesanan",
            style: BLACK_TEXT_STYLE.copyWith(
                fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Stack(
          children: [
            _headerContent(),
            Align(
              alignment: Alignment.bottomCenter,
              child: _filter(),
            )
          ],
        )));
  }

  Widget _headerContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: SingleChildScrollView(
        child: BlocBuilder<DataOrderCubit, DataOrderState>(
          builder: (context, state) {
            if (state is DataOrderLoading) {
              return _shimmerContent();
            } else if (state is DataOrderEmpty) {
              return Center(
                child: Column(
                  children: [
                    Image.asset("assets/icons/like_product.png",
                        fit: BoxFit.cover),
                    Text(
                      "Pesanan Anda kosong nih, silahkan pesan sekarang",
                      textAlign: TextAlign.center,
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontSize: 18, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                    )
                  ],
                ),
              );
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }

  Widget _filter() {
    return GestureDetector(
      onTap: () {
        sheetFilter();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.380,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: ColorUI.NAVY,
          borderRadius: BorderRadius.circular(55),
          boxShadow: [
            BoxShadow(
              color: ColorUI.NAVY.withOpacity(0.7),
              spreadRadius: 0.2,
              blurRadius: 12,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text("Filter",
                    style: WHITE_TEXT_STYLE.copyWith(
                        fontSize: 16, fontWeight: FontUI.WEIGHT_MEDIUM))),
            const SizedBox(width: 10),
            Flexible(
                child: Image.asset(
              "assets/icons/icon_filter.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).textScaleFactor * 17,
              height: MediaQuery.of(context).textScaleFactor * 15,
            ))
          ],
        ),
      ),
    );
  }

  void sheetFilter() {
    showModalBottomSheet(
        barrierColor: ColorUI.BLACK.withOpacity(0.2),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStater) {
            return makeDismiss(
              context,
              child: DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.4,
                  maxChildSize: 1,
                  builder: (context, controller) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: ColorUI.WHITE,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          )),
                      child: Stack(
                        children: [
                          ListView(
                            controller: controller,
                            primary: false,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 50),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              primary: false,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: const Divider(thickness: 1.5),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                            spacing: 3,
                                            direction: Axis.horizontal,
                                            children: orderFilter.map((e) {
                                              return ChipFilterStatus(
                                                  filter: e['title'],
                                                  value: e['value'].toString(),
                                                  groupValue: hasFilter,
                                                  onChanged: (String? value) {
                                                    setStater(() {
                                                      hasFilter = value!;
                                                    });
                                                    print(value);
                                                  });
                                            }).toList()),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    PrimaryButton(
                                        text: 'Terapkan',
                                        onPressed: () async {
                                          await context
                                              .read<DataOrderCubit>()
                                              .getAllOrder(context, hasFilter)
                                              .then((value) =>
                                                  Navigator.pop(context));
                                          setState(() {});
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 12, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close_rounded),
                                    iconSize: 20,
                                    color: ColorUI.BLACK),
                                Text("Filter",
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                                        color: ColorUI.BLACK.withOpacity(.70))),
                                const SizedBox(width: 30)
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          });
        });
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
