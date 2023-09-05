import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/card/card_promo_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        onTap: () {},
                        child: Row(children: [
                          Text("Edit ",
                              style: BROWN_TEXT_STYLE.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontUI.WEIGHT_MEDIUM)),
                          const Icon(Icons.mode_edit_outlined,
                              size: 14, color: ColorUI.BROWN)
                        ]),
                      ),
                      Text("Reza Putra Pratama",
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontSize: 16,
                              fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const CardPromoProfile(),
              const SizedBox(height: 20),
              _listProfile(() {
                debugPrint("Go to all pesanan");
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
                debugPrint("Go to bantuan");
              }, Icons.help_outline_rounded, "Bantuan"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1),
              const SizedBox(height: 10),
              _listProfile(() {
                debugPrint("Go to ketentuan layanan");
              }, Icons.info_outline, "Ketentuan Layanan"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1),
              const SizedBox(height: 10),
              _listProfile(() {
                debugPrint("Go to kebijakan privasi");
              }, Icons.library_books_outlined, "Kebijakan Privasi"),
              const SizedBox(height: 10),
              const Divider(height: 2, thickness: 1)
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
