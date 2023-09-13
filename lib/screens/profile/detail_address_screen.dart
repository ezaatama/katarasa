import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:katarasa/data/profile/detail_address/detail_address_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/profile/card_single_alamat.dart';

class DetailAddressScreen extends StatefulWidget {
  const DetailAddressScreen({super.key});

  @override
  State<DetailAddressScreen> createState() => _DetailAddressScreenState();
}

class _DetailAddressScreenState extends State<DetailAddressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailAddressCubit>().getListAddress(context);
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
            "Detail Alamat",
            style: BLACK_TEXT_STYLE.copyWith(
                fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: BlocBuilder<DetailAddressCubit, DetailAddressState>(
              builder: (context, state) {
                if (state is DetailAddressLoading) {
                  return const Center(child: LoaderIndicator());
                } else if (state is DetailAddressEmpty) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/address_order.svg",
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .300,
                        ),
                        const SizedBox(height: 20),
                        Text(
                            "Anda belum menambahkan alamat,\nSilahkan tambah alamat terlebih dahulu!",
                            textAlign: TextAlign.center,
                            style: BLACK_TEXT_STYLE.copyWith(
                                fontSize: 18,
                                fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                        const SizedBox(height: 20),
                        PrimaryButton(
                            text: "Tambah Alamat",
                            onPressed: () {
                              debugPrint("tambah alamat by modal or screen");
                              Navigator.pushNamed(context, '/add-new-address');
                            })
                      ],
                    ),
                  );
                } else if (state is DetailAddressLoaded) {
                  final detailAlamat = state.detailAlamat;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Alamat Utama",
                            style: BLACK_TEXT_STYLE.copyWith(
                                fontWeight: FontUI.WEIGHT_BOLD, fontSize: 20)),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: detailAlamat.length,
                            itemBuilder: (context, index) {
                              return CardSingleAlamat(
                                detail: detailAlamat[index],
                              );
                            }),
                        const SizedBox(height: 20),
                        PrimaryButton(
                            text: "Tambah Alamat",
                            onPressed: () {
                              Navigator.pushNamed(context, '/add-new-address');
                            })
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          )),
        ));
  }
}
