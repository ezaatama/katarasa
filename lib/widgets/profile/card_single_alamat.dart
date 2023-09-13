import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/profile/detail_address/detail_address_cubit.dart';
import 'package:katarasa/data/profile/edit_address/edit_address_cubit.dart';
import 'package:katarasa/models/profile/detail_alamat/detail_alamat_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/custom/customize_action_dialog.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

class CardSingleAlamat extends StatelessWidget {
  CardSingleAlamat({super.key, required this.detail});

  DetailAlamat detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorUI.WHITE,
          boxShadow: [
            BoxShadow(
              color: ColorUI.GREY.withOpacity(.20),
              offset: const Offset(
                2.0,
                2.0,
              ),
              blurRadius: 12.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            const BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.person_pin_circle_outlined,
                  size: 26, color: ColorUI.BROWN.withOpacity(.60)),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.addressAs.toUpperCase(),
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${detail.completeAddress}, ${detail.province.name}, ${detail.city.name}, ${detail.district.name}, ${detail.subDistrict.name} ${detail.postalCode}",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_LIGHT),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "(Penerima - ${detail.receiverName})",
                      style: RED_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit-address',
                            arguments: detail.id);
                        debugPrint("go to detail edit address => ${detail.id}");
                      },
                      icon: const Icon(
                        Icons.mode_edit_outlined,
                        color: ColorUI.BROWN,
                        size: 26,
                      )),
                  BlocConsumer<EditAddressCubit, EditAddressState>(
                    listener: (context, state) {
                      if (state is RemoveAddressSuccess) {
                        showToast(
                            text: state.removeSucc, state: ToastStates.SUCCESS);
                        context
                            .read<DetailAddressCubit>()
                            .getListAddress(context);
                      } else if (state is RemoveAddressError) {
                        showToast(
                            text: state.removeErr, state: ToastStates.ERROR);
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            showActionDialog(context,
                                title:
                                    "Apakah Anda yakin ingin menghapus alamat ini?",
                                tapBatalkan: () {
                              context
                                  .read<EditAddressCubit>()
                                  .deleteAddress(detail.id, context);
                            }, tapTidakBatal: () {
                              Navigator.pop(context);
                            });
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 26,
                          ));
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
