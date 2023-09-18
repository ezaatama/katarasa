import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/profile/data_profile/profile_cubit.dart';
import 'package:katarasa/models/auth/register/register_request.dart';
import 'package:katarasa/models/profile/data_profile/data_profile_request.dart';
import 'package:katarasa/models/profile/tanggal_lahir.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/button/loading_button.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/customize_text_field.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _genderOption;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getDataProfile(context);
  }

  @override
  Widget build(BuildContext context) {
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
            "Ubah Profile",
            style: BLACK_TEXT_STYLE.copyWith(
                fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
          ),
          centerTitle: true,
        ),
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
            child: _bodyContent()));
  }

  Widget _bodyContent() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorUI.WHITE,
      body: SafeArea(child: LayoutBuilder(builder: (context, constraint) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(children: [
                  _formContent(),
                ]),
              ),
            ),
          ),
        );
      })),
    );
  }

  Widget _formContent() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        if (state is ProfileLoading) {
          return const Center(child: LoaderIndicator());
        } else if (state is ProfileLoaded) {
          //gender
          var existingGender = state.dataProfile.genderId;
          //birthdate
          String birthday = state.dataProfile.birthDate;
          var splitBirthday = birthday.split(" ");
          var getYear = birthday.isEmpty ? 'Tahun' : splitBirthday.elementAt(2);
          var getMonth =
              birthday.isEmpty ? 'Bulan' : splitBirthday.elementAt(1);
          var getDay = birthday.isEmpty ? 'Tgl' : splitBirthday.elementAt(0);
          var valDay = TanggalLahir.dateBirthDay ?? getDay;
          var valMonth = TanggalLahir.dateBirthMonth ?? getMonth;
          var valYear = TanggalLahir.dateBirthYear ?? getYear;
          var postBirthday = "$valYear-$valMonth-$valDay";
          switch (getMonth) {
            case "01":
              getMonth = "January";
              break;
            case "02":
              getMonth = "February";
              break;
            case "03":
              getMonth = "March";
              break;
            case "04":
              getMonth = "April";
              break;
            case "05":
              getMonth = "May";
              break;
            case "06":
              getMonth = "June";
              break;
            case "07":
              getMonth = "July";
              break;
            case "08":
              getMonth = "August";
              break;
            case "09":
              getMonth = "September";
              break;
            case "10":
              getMonth = "October";
              break;
            case "11":
              getMonth = "November";
              break;
            case "12":
              getMonth = "December";
              break;
            default:
              // getMonth = "Januari";
              break;
          }
          return Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Lengkap",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _nameController.text.isEmpty
                        ? _nameController
                        : _nameController
                      ..text = state.dataProfile.name,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name wajib diisi!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nameController.text = value!;
                      debugPrint(value);
                    },
                    onChanged: (String? newValue) {
                      state.dataProfile.name = newValue!;
                    },
                    hintText: "Nama Lengkap",
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "No. HP",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _phoneController.text.isEmpty
                        ? _phoneController
                        : _phoneController
                      ..text = state.dataProfile.phoneNumber,
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
                    onSaved: (value) {
                      _phoneController.text = value!;
                      debugPrint(value);
                    },
                    onChanged: (String? newValue) {
                      state.dataProfile.phoneNumber = newValue!;
                    },
                    hintText: "No. Hp",
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tanggal Lahir",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .320,
                                child: DropdownButtonFormField2(
                                    hint: state.dataProfile.birthDate.isNotEmpty
                                        ? birthday.isEmpty
                                            ? Text(getYear.toString(),
                                                style: LIGHT_BROWN_TEXT_STYLE
                                                    .copyWith(fontSize: 12))
                                            : Text(getYear.toString(),
                                                style: BLACK_TEXT_STYLE
                                                    .copyWith(fontSize: 12))
                                        : Text("Tahun",
                                            style: LIGHT_BROWN_TEXT_STYLE
                                                .copyWith(fontSize: 12)),
                                    isExpanded: true,
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                          Icons.keyboard_arrow_down_rounded),
                                    ),
                                    buttonStyleData: const ButtonStyleData(
                                      height: 60,
                                      padding: EdgeInsets.only(right: 10),
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: TanggalLahir.onError
                                            ? BorderSide(
                                                color:
                                                    Colors.red.withOpacity(.80))
                                            : BorderSide(
                                                color: ColorUI.BROWN
                                                    .withOpacity(.30)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: TanggalLahir.onError
                                            ? BorderSide(
                                                color:
                                                    Colors.red.withOpacity(.80))
                                            : BorderSide(
                                                color: ColorUI.BROWN
                                                    .withOpacity(.30)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                ColorUI.BROWN.withOpacity(.30)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: ColorUI.WHITE,
                                    ),
                                    validator: (value) {
                                      // if (value == null) {
                                      //   return 'Tanggal lahir wajib diisi!';
                                      // }
                                      setState(() {
                                        TanggalLahir.onError = false;
                                      });
                                      if (state
                                          .dataProfile.birthDate.isNotEmpty) {
                                        return null;
                                      } else {
                                        if (value == null) {
                                          setState(() {
                                            TanggalLahir.onError = true;
                                          });
                                          return '';
                                        } else if (TanggalLahir.dateBirthDay! >
                                            TanggalLahir.daysInMonth(
                                                TanggalLahir.dateBirthMonth,
                                                TanggalLahir.dateBirthYear!)) {
                                          setState(() {
                                            TanggalLahir.onError = true;
                                          });
                                          return '';
                                        }
                                        return null;
                                      }
                                    },
                                    onSaved: (int? value) {
                                      if (value != null) {
                                        TanggalLahir.dateBirthYear = value;
                                      } else {
                                        TanggalLahir.dateBirthYear = value;
                                      }
                                    },
                                    value: TanggalLahir.dateBirthYear,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        TanggalLahir.dateBirthYear = newValue!;
                                      });
                                    },
                                    items: [
                                      for (var i = TanggalLahir.n;
                                          i >= 1900;
                                          i--)
                                        DropdownMenuItem(
                                            value: i,
                                            child: Text(i.toString(),
                                                style: const TextStyle(
                                                    fontSize: 14)))
                                    ])),
                            const SizedBox(width: 5),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.350,
                                child: DropdownButtonFormField2(
                                    hint: state.dataProfile.birthDate.isNotEmpty
                                        ? birthday.isEmpty
                                            ? Text(getMonth.toString(),
                                                style: LIGHT_BROWN_TEXT_STYLE
                                                    .copyWith(fontSize: 12))
                                            : Text(getMonth.toString(),
                                                style: BLACK_TEXT_STYLE
                                                    .copyWith(fontSize: 12))
                                        : Text("Bulan",
                                            style: LIGHT_BROWN_TEXT_STYLE
                                                .copyWith(fontSize: 12)),
                                    isExpanded: true,
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                          Icons.keyboard_arrow_down_rounded),
                                    ),
                                    buttonStyleData: const ButtonStyleData(
                                      height: 60,
                                      padding: EdgeInsets.only(right: 10),
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: TanggalLahir.onError
                                            ? BorderSide(
                                                color:
                                                    Colors.red.withOpacity(.80))
                                            : BorderSide(
                                                color: ColorUI.BROWN
                                                    .withOpacity(.30)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: TanggalLahir.onError
                                            ? BorderSide(
                                                color:
                                                    Colors.red.withOpacity(.80))
                                            : BorderSide(
                                                color: ColorUI.BROWN
                                                    .withOpacity(.30)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                ColorUI.BROWN.withOpacity(.30)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: ColorUI.WHITE,
                                    ),
                                    validator: (value) {
                                      // if (value == null) {
                                      //   return 'Bulan lahir wajib diisi!';
                                      // }
                                      setState(() {
                                        TanggalLahir.onError = false;
                                      });
                                      if (state
                                          .dataProfile.birthDate.isNotEmpty) {
                                        return null;
                                      } else {
                                        if (value == null) {
                                          setState(() {
                                            TanggalLahir.onError = true;
                                          });
                                          return '';
                                        } else if (TanggalLahir.dateBirthDay! >
                                            TanggalLahir.daysInMonth(
                                                TanggalLahir.dateBirthMonth,
                                                TanggalLahir.dateBirthYear!)) {
                                          setState(() {
                                            TanggalLahir.onError = true;
                                          });
                                          return '';
                                        }
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      if (value != null) {
                                        TanggalLahir.dateBirthMonth = value;
                                      } else {
                                        TanggalLahir.dateBirthMonth = value;
                                      }
                                    },
                                    value: TanggalLahir.dateBirthMonth,
                                    onChanged: (newValue) {
                                      setState(() {
                                        TanggalLahir.dateBirthMonth = newValue!;
                                      });
                                    },
                                    items: TanggalLahir.listMonths.map((e) {
                                      return DropdownMenuItem(
                                          value: e['id'],
                                          child: Text(e['value'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 14)));
                                    }).toList())),
                            const SizedBox(width: 5),
                            Flexible(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.240,
                                  child: DropdownButtonFormField2(
                                      hint: state
                                              .dataProfile.birthDate.isNotEmpty
                                          ? birthday.isEmpty
                                              ? Text(getDay.toString(),
                                                  style: LIGHT_BROWN_TEXT_STYLE
                                                      .copyWith(fontSize: 12))
                                              : Text(getDay.toString(),
                                                  style: BLACK_TEXT_STYLE
                                                      .copyWith(fontSize: 12))
                                          : Text("Tgl",
                                              style: LIGHT_BROWN_TEXT_STYLE
                                                  .copyWith(fontSize: 12)),
                                      isExpanded: true,
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_rounded),
                                      ),
                                      buttonStyleData: const ButtonStyleData(
                                        height: 60,
                                        padding: EdgeInsets.only(right: 10),
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: TanggalLahir.onError
                                              ? BorderSide(
                                                  color: Colors.red
                                                      .withOpacity(.80))
                                              : BorderSide(
                                                  color: ColorUI.BROWN
                                                      .withOpacity(.30)),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: TanggalLahir.onError
                                              ? BorderSide(
                                                  color: Colors.red
                                                      .withOpacity(.80))
                                              : BorderSide(
                                                  color: ColorUI.BROWN
                                                      .withOpacity(.30)),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorUI.BROWN
                                                  .withOpacity(.30)),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: ColorUI.WHITE,
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          TanggalLahir.onError = false;
                                        });
                                        if (state
                                            .dataProfile.birthDate.isNotEmpty) {
                                          return null;
                                        } else {
                                          if (value == null) {
                                            setState(() {
                                              TanggalLahir.onError = true;
                                            });
                                            return '';
                                          } else if (TanggalLahir
                                                  .dateBirthDay! >
                                              TanggalLahir.daysInMonth(
                                                  TanggalLahir.dateBirthMonth,
                                                  TanggalLahir
                                                      .dateBirthYear!)) {
                                            setState(() {
                                              TanggalLahir.onError = true;
                                            });
                                            return '';
                                          }
                                        }
                                        return null;
                                        // if (value == null) {
                                        //   return 'Tahun lahir wajib diisi!';
                                        // } else if (TanggalLahir.dateBirthDay! >
                                        //     TanggalLahir.daysInMonth(
                                        //         TanggalLahir.dateBirthMonth,
                                        //         TanggalLahir.dateBirthYear!)) {
                                        //   return ('Masukkan tanggal lahir yang benar');
                                        // }
                                        // return null;
                                      },
                                      onSaved: (int? value) {
                                        if (value != null) {
                                          TanggalLahir.dateBirthDay = value;
                                        } else {
                                          TanggalLahir.dateBirthDay = value;
                                        }
                                      },
                                      value: TanggalLahir.dateBirthDay,
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          TanggalLahir.dateBirthDay = newValue!;
                                        });
                                      },
                                      items: [
                                        for (var i = 1; i <= 31; i++)
                                          DropdownMenuItem(
                                              value: i,
                                              child: Text(i.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14)))
                                      ])),
                            ),
                          ],
                        ),
                      ),
                      TanggalLahir.onError
                          ? state.dataProfile.birthDate.isNotEmpty
                              ? Container()
                              : Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, left: 15),
                                  child: const Text(
                                      'Masukkan tanggal lahir yang benar',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400)),
                                )
                          : Container()
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("Jenis Kelamin",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                  const SizedBox(height: 10),
                  RegisterRequest.gender.isNotEmpty
                      ? DropdownButtonFormField2<String>(
                          hint: state.dataProfile.genderId.isEmpty
                              ? Text(
                                  "Jenis Kelamin",
                                  style: LIGHT_BROWN_TEXT_STYLE.copyWith(
                                      fontSize: 14),
                                )
                              : Text(state.dataProfile.genderId,
                                  style:
                                      BLACK_TEXT_STYLE.copyWith(fontSize: 14)),
                          isExpanded: true,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorUI.BROWN.withOpacity(.60)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorUI.BROWN.withOpacity(.60)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorUI.BROWN.withOpacity(.50)),
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
                            if (state.dataProfile.genderId.isEmpty) {
                              if (value == null) {
                                return 'Jenis kelamin wajib diisi!';
                              } else {
                                return null;
                              }
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            if (value!.isEmpty) {
                              _genderOption = value.toString();
                            } else {
                              _genderOption = value;
                            }
                          },
                          value: _genderOption,
                          onChanged: (String? newValue) {
                            setState(() {
                              _genderOption = newValue!;
                              debugPrint("ini choice gender => $_genderOption");
                            });
                          },
                          items: RegisterRequest.gender.map((e) {
                            return DropdownMenuItem(
                                value: e,
                                child: Text(e,
                                    style: const TextStyle(fontSize: 14)));
                          }).toList())
                      : const SizedBox(),
                  const SizedBox(height: 30),
                  BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileUpdated) {
                        showToast(
                            text: "Data berhasil diubah!",
                            state: ToastStates.SUCCESS);
                        Navigator.pushReplacementNamed(
                          context,
                          '/home',
                        );
                      } else if (state is ProfileError) {
                        showToast(
                            text: state.profileError, state: ToastStates.ERROR);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          cubit.isUpdateDataDiri
                              ? LoadingButton(onPressed: () {
                                  debugPrint(
                                      "Loading Response upadte data diri");
                                })
                              : PrimaryButton(
                                  text: "Simpan Data",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      UpdateProfileRequest payload =
                                          UpdateProfileRequest(
                                              namaLengkap: _nameController.text,
                                              tanggalLahir: postBirthday,
                                              phoneNumber:
                                                  _phoneController.text,
                                              genderId: _genderOption == null
                                                  ? existingGender ==
                                                          'Laki-laki'
                                                      ? '1'
                                                      : '2'
                                                  : _genderOption == 'Laki-laki'
                                                      ? '1'
                                                      : '2',
                                              nip: "",
                                              corporate: "",
                                              department: "");
                                      debugPrint(
                                          "ini tanggal lahir => $postBirthday");
                                      debugPrint(
                                          "ini jenis kelamin tidak dipilih => $existingGender");
                                      debugPrint(
                                          "ini jenis kelamin dipilih => $_genderOption");
                                      context
                                          .read<ProfileCubit>()
                                          .postDataProfile(payload, context);
                                    }
                                  }),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
