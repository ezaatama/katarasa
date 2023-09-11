// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/profile/select_address/kota/kota_cubit.dart';
import 'package:katarasa/data/profile/select_address/provinsi/provinsi_cubit.dart';
import 'package:katarasa/models/profile/detail_alamat/detail_alamat_request.dart';
import 'package:katarasa/models/profile/select_address/alamat_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/customize_text_field.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _jenisAlamat;
  final TextEditingController _fullAddressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  SelectProvinsi? _selectProvinsi;
  SelectKota? _selectKota;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // AddressCubit addressCubit = context.read<AddressCubit>();
    await context.read<ProvinsiCubit>().getListProvince(context);

    // var addressProv = await addressCubit.getListProvince(context);
    // var addressKota =
    //     await addressCubit.getListKota(context, addressProv!.provinceId);

    // if (addressProv != null && addressKota != null) {
    //   preSelectData(addressProv, addressKota);
    // }
  }

  Future<void> preSelectData(SelectProvinsi prov, SelectKota kota) async {
    KotaCubit kotaCubit = context.read<KotaCubit>();
    //set on time value
    _selectProvinsi = context
        .read<ProvinsiCubit>()
        .getDropdownProvinsi()
        .firstWhereOrNull((e) => e.provinceId == prov.provinceId);

    if (_selectProvinsi != null) {
      await kotaCubit.getListKota(context, prov.provinceId);
      _selectKota = context
          .read<KotaCubit>()
          .getDropdownKota()
          .firstWhereOrNull((e) => e.cityId == kota.cityId);
    }

    setState(() {});
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
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorUI.WHITE,
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
          "Tambah Alamat",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: LayoutBuilder(builder: (context, constraint) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _formContent(),
                  ],
                ),
              ),
            ),
          ),
        );
      })),
    );
  }

  Widget _formContent() {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Alamat Lengkap",
              style: BLACK_TEXT_STYLE.copyWith(
                  fontWeight: FontUI.WEIGHT_SEMI_BOLD),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _fullAddressController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alamat lengkap tidak boleh kosong';
                }
                return null;
              },
              hintText: "Alamat Lengkap",
            ),
            const SizedBox(height: 10),
            Text("Jenis Alamat",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
            const SizedBox(height: 10),
            DetailAlamatRequest.namaAlamat.isNotEmpty
                ? DropdownButtonFormField2<String>(
                    hint: Text(
                      "Jenis Alamat",
                      style: LIGHT_BROWN_TEXT_STYLE.copyWith(fontSize: 14),
                    ),
                    isExpanded: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorUI.BROWN.withOpacity(.60)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorUI.BROWN.withOpacity(.60)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorUI.BROWN.withOpacity(.50)),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      filled: true,
                      fillColor: ColorUI.WHITE,
                    ),
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            border: Border.fromBorderSide(
                      BorderSide(color: ColorUI.BROWN.withOpacity(.50)),
                    ))),
                    validator: (value) {
                      // if (state.dataProfile.genderId.isEmpty) {
                      if (value == null) {
                        return 'Jenis alamat wajib diisi!';
                      } else {
                        return null;
                      }
                      // }
                      // return null;
                    },
                    onSaved: (String? value) {
                      if (value!.isEmpty) {
                        _jenisAlamat = value.toString();
                      } else {
                        _jenisAlamat = value;
                      }
                    },
                    value: _jenisAlamat,
                    onChanged: (String? newValue) {
                      setState(() {
                        _jenisAlamat = newValue!;
                        debugPrint("ini choice jenis alamat => $_jenisAlamat");
                      });
                    },
                    items: DetailAlamatRequest.namaAlamat.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Text(e, style: const TextStyle(fontSize: 14)));
                    }).toList())
                : const SizedBox(),
            const SizedBox(height: 10),
            Text("Pilih Provinsi",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
            const SizedBox(height: 10),
            BlocBuilder<ProvinsiCubit, ProvinsiState>(
              builder: (context, state) {
                if (state is ProvinsiLoading) {
                  return const LoaderIndicator();
                }
                if (state is ProvinsiLoaded) {
                  return DropdownButtonFormField2<SelectProvinsi>(
                      hint: Text("Provinsi",
                          style: LIGHT_BROWN_TEXT_STYLE.copyWith(fontSize: 14)),
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                              border: Border.fromBorderSide(
                        BorderSide(color: ColorUI.BROWN.withOpacity(.50)),
                      ))),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorUI.BROWN.withOpacity(.30)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorUI.BROWN.withOpacity(.30)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: ColorUI.WHITE,
                      ),
                      validator: (value) {
                        // if (alamatProv == null) {
                        if (value == null) {
                          return 'Pilih provinsi Anda.';
                        }
                        return null;
                        // }
                        // return null;
                      },
                      onSaved: (value) {
                        _selectProvinsi = value;
                      },
                      value: _selectProvinsi,
                      onChanged: (newValue) {
                        _selectProvinsi = newValue;
                        context
                            .read<KotaCubit>()
                            .getListKota(context, newValue!.provinceId);
                      },
                      items: state.listProvinsi.map((e) {
                        return DropdownMenuItem<SelectProvinsi>(
                            value: e,
                            child: Text(e.name,
                                style: const TextStyle(fontSize: 14)));
                      }).toList());
                } else if (state is ProvinsiError) {
                  return const Center(
                    child: Text("Terjadi kesalahan silahkan coba lagi nanti!"),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 10),

            //kota
            Text("Pilih Kota",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
            const SizedBox(height: 10),
            BlocBuilder<KotaCubit, KotaState>(
              builder: (context, state) {
                if (state is KotaLoading) {
                  return const LoaderIndicator();
                }
                if (state is KotaLoaded) {
                  if (_selectKota != null) {
                    SelectKota? checkKota = state.listKota.firstWhereOrNull(
                        (e) => e.cityId == _selectKota!.cityId);

                    if (checkKota == null) {
                      _selectKota = null;
                    }
                  }
                  return DropdownButtonFormField2<SelectKota>(
                      hint: Text("Kota",
                          style: LIGHT_BROWN_TEXT_STYLE.copyWith(fontSize: 14)),
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                              border: Border.fromBorderSide(
                        BorderSide(color: ColorUI.BROWN.withOpacity(.50)),
                      ))),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorUI.BROWN.withOpacity(.30)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorUI.BROWN.withOpacity(.30)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: ColorUI.WHITE,
                      ),
                      validator: (value) {
                        // if (alamatProv == null) {
                        if (value == null) {
                          return 'Pilih kota Anda.';
                        }
                        return null;
                        // }
                        // return null;
                      },
                      onSaved: (value) {
                        _selectKota = value;
                      },
                      value: _selectKota,
                      onChanged: (newValue) {
                        _selectKota = newValue;
                        // context
                        //     .read<KotaCubit>()
                        //     .getListCities(newValue!.id);
                      },
                      items: state.listKota.map((e) {
                        return DropdownMenuItem<SelectKota>(
                            value: e,
                            child: Text(e.name,
                                style: const TextStyle(fontSize: 14)));
                      }).toList());
                } else if (state is KotaError) {
                  return const Center(
                    child: Text("Terjadi kesalahan silahkan coba lagi nanti!"),
                  );
                }
                return DropdownButtonFormField2<SelectKota>(
                    hint: Text("Kota",
                        style: LIGHT_BROWN_TEXT_STYLE.copyWith(fontSize: 14)),
                    isExpanded: true,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            border: Border.fromBorderSide(
                      BorderSide(color: ColorUI.BROWN.withOpacity(.50)),
                    ))),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorUI.BROWN.withOpacity(.30)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorUI.BROWN.withOpacity(.30)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: ColorUI.WHITE,
                    ),
                    validator: (value) {
                      // if (alamatProv == null) {
                      if (value == null) {
                        return 'Pilih kota Anda.';
                      }
                      return null;
                      // }
                      // return null;
                    },
                    onSaved: (value) {
                      _selectKota = value;
                    },
                    value: _selectKota,
                    onChanged: (newValue) {
                      _selectKota = newValue;
                      // context
                      //     .read<KotaCubit>()
                      //     .getListCities(newValue!.id);
                    },
                    items: []);
              },
            ),
            const SizedBox(height: 10),
            Text(
              "Nama Penerima",
              style: BLACK_TEXT_STYLE.copyWith(
                  fontWeight: FontUI.WEIGHT_SEMI_BOLD),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama penerima tidak boleh kosong';
                }
                return null;
              },
              hintText: "Nama Penerima",
            ),
            const SizedBox(height: 10),
            Text(
              "No. HP",
              style: BLACK_TEXT_STYLE.copyWith(
                  fontWeight: FontUI.WEIGHT_SEMI_BOLD),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'No. Hp wajib diisi!';
                } else if (!isValidPhoneNumber(value)) {
                  return 'Masukkan nomor hp yang benar!';
                }
                return null;
              },
              hintText: "Phone Number",
            ),
            const SizedBox(height: 40),
            PrimaryButton(
                text: "Simpan Alamat",
                onPressed: () {
                  debugPrint("alamat disimpan");
                })
          ],
        ),
      ),
    );
  }
}
