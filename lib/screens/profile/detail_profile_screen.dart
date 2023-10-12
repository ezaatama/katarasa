import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/profile/data_profile/profile_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/profile/card_detail_profile.dart';
import 'package:shimmer/shimmer.dart';

class DetailProfileScreen extends StatefulWidget {
  const DetailProfileScreen({super.key});

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getDataProfile(context);
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
          "Detail Profile",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        actions: [
          InkWell(
            onTap: () {
              debugPrint("Go to edit profile");
              Navigator.pushNamed(context, '/edit-profile');
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: ColorUI.BROWN),
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                "Ubah",
                style:
                    BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_LIGHT),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: ColorUI.SHIMMER_BASE,
                            highlightColor: ColorUI.SHIMMER_HIGHLIGHT,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              height:
                                  MediaQuery.of(context).size.height * 0.040,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: ColorUI.SHIMMER_BASE,
                              ),
                            ));
                      }));
            } else if (state is ProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Center(
                      child: Text(
                        "Pastikan data diri Anda sudah benar! Silahkan periksa kembali data diri Anda!",
                        textAlign: TextAlign.center,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontWeight: FontUI.WEIGHT_LIGHT),
                      ),
                    ),
                  ),
                  CardDetailProfile(
                      title: "Nama Lengkap", value: state.dataProfile.name),
                  CardDetailProfile(
                      title: "Email", value: state.dataProfile.email),
                  CardDetailProfile(
                      title: "No. HP", value: state.dataProfile.phoneNumber),
                  CardDetailProfile(
                      title: "Tanggal Lahir",
                      value: state.dataProfile.birthDate),
                  CardDetailProfile(
                      title: "Jenis Kelamin", value: state.dataProfile.genderId)
                ],
              );
            }
            return const SizedBox();
          },
        ),
      )),
    );
  }
}
