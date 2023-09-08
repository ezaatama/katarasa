import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/profile/data_profile/profile_cubit.dart';
import 'package:katarasa/utils/cache_storage.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/card/card_promo_profile.dart';
import 'package:katarasa/widgets/general/loader.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getDataProfile(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/logokatarasa.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * .125,
                      height: MediaQuery.of(context).size.height * .060),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/detail-profile');
                        },
                        child: Text("Lihat Profil",
                            style: BROWN_TEXT_STYLE.copyWith(
                                fontSize: 12,
                                fontWeight: FontUI.WEIGHT_MEDIUM)),
                      ),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * .400,
                              height:
                                  MediaQuery.of(context).size.height * 0.030,
                              child: Shimmer.fromColors(
                                  baseColor: ColorUI.SHIMMER_BASE,
                                  highlightColor: ColorUI.SHIMMER_HIGHLIGHT,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: ColorUI.SHIMMER_BASE,
                                    ),
                                  )),
                            );
                          } else if (state is ProfileLoaded) {
                            return Text(state.dataProfile.name,
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontUI.WEIGHT_SEMI_BOLD));
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const CardPromoProfile(),
              const SizedBox(height: 20),
              _listProfile(() {
                debugPrint("Go to all pesanan");
                Navigator.pushNamed(context, '/all-order');
              }, Icons.list, "Semua Pesanan"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1),
              const SizedBox(height: 10),
              _listProfile(() {
                debugPrint("Go to alamat pengiriman");
              }, Icons.location_history, "Alamat Pengiriman"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1),
              const SizedBox(height: 10),
              _listProfile(() {
                debugPrint("Go to ubah password");
                Navigator.pushNamed(context, '/edit-password');
              }, Icons.key_rounded, "Ubah Password"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1),
              const SizedBox(height: 10),
              _listProfile(() {
                debugPrint("Go to bantuan");
              }, Icons.help_outline_rounded, "Bantuan"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1),
              const SizedBox(height: 10),
              _listProfile(() {
                debugPrint("Go to ketentuan layanan");
                Navigator.pushNamed(context, '/service');
              }, Icons.info_outline, "Ketentuan Layanan"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1),
              const SizedBox(height: 10),
              _listProfile(() {
                debugPrint("Go to kebijakan privasi");
              }, Icons.library_books_outlined, "Kebijakan Privasi"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1),
              const SizedBox(height: 10),
              _listProfile(() {
                debugPrint("Go to tentang kami");
                Navigator.pushNamed(context, '/about-us');
              }, Icons.people_outline, "Tentang Kami"),
              const SizedBox(height: 30),
              PrimaryButton(
                  text: "Keluar",
                  onPressed: () async {
                    CacheStorage.setTokenApi('');
                    initTokenHeader('');
                    debugPrint('token remove');
                    showToast(
                        text: "Anda berhasil logout!",
                        state: ToastStates.SUCCESS);
                    Navigator.pushReplacementNamed(context, '/');
                  })
            ],
          ),
        ),
      )),
    );
  }

  Widget _listProfile(Function()? onTap, IconData icon, String title) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: ColorUI.BROWN,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: BLACK_TEXT_STYLE.copyWith(
                fontSize: 18, fontWeight: FontUI.WEIGHT_MEDIUM),
          ),
        ],
      ),
    );
  }
}
