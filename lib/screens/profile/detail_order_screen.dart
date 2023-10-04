import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/order/detail_order/detail_order_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/order/card_detail_order.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines/timelines.dart';

class DetailOrderScreen extends StatefulWidget {
  const DetailOrderScreen({super.key, required this.idOrder});

  final String idOrder;

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailOrderCubit>().getDetailOrder(context, widget.idOrder);
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
          "Detail Pesanan",
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
        child: SingleChildScrollView(child:
            BlocBuilder<DetailOrderCubit, DetailOrderState>(
                builder: (context, state) {
          if (state is DetailOrderLoading) {
            return _shimmerContent();
          } else if (state is DetailOrderLoaded) {
            return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: state.detailOrderLoaded.items.length,
                itemBuilder: (context, index) {
                  final detail = state.detailOrderLoaded;
                  final item = detail.items[index];
                  final product = item.products[index];
                  return CardDetailOrder(
                    detail: detail,
                    detailItem: item,
                    detailProduct: product,
                    detailHistory: Timeline.tileBuilder(
                      theme: TimelineThemeData(
                          direction: Axis.horizontal,
                          connectorTheme: ConnectorThemeData(
                              color: ColorUI.BROWN.withOpacity(.40)),
                          indicatorTheme:
                              const IndicatorThemeData(color: ColorUI.BROWN)),
                      builder: TimelineTileBuilder.connectedFromStyle(
                        lastConnectorStyle: ConnectorStyle.transparent,
                        connectionDirection: ConnectionDirection.before,
                        connectorStyleBuilder: (context, index) {
                          return (detail.orderHistory[index].isActive == false)
                              ? ConnectorStyle.dashedLine
                              : ConnectorStyle.solidLine;
                        },
                        indicatorStyleBuilder: (context, index) {
                          return (detail.orderHistory[index].isActive == false)
                              ? IndicatorStyle.outlined
                              : IndicatorStyle.dot;
                        },
                        contentsAlign: ContentsAlign.alternating,
                        contentsBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(detail.orderHistory[index].name),
                        ),
                        itemCount: detail.orderHistory.length,
                      ),
                    ),
                  );
                });
          }
          return const SizedBox();
        })),
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
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .060,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .500,
                color: Colors.white,
              ),
            ],
          )),
    );
  }
}
