import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/auth/register/register_cubit.dart';
import 'package:katarasa/models/auth/register/register_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/button/loading_button.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/customize_text_field.dart';
import 'package:katarasa/widgets/general/icon_suffix.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = false;
  String? _genderOption;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    const Expanded(flex: 1, child: SizedBox()),
                    _formContent(),
                    const Expanded(flex: 1, child: SizedBox()),
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
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Image.asset(
                "assets/images/logokatarasa.png",
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * .450,
                height: MediaQuery.of(context).size.height * .200,
              )),
              const SizedBox(height: 10),
              Text(
                "Name",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _usernameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan username yang benar!';
                  }
                  return null;
                },
                hintText: "Name",
              ),
              const SizedBox(height: 10),
              Text(
                "Email",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email wajib diisi!';
                  } else if (!isValidEmail(value)) {
                    return 'Masukkan email yang benar!';
                  }
                  return null;
                },
                hintText: "Email",
              ),
              const SizedBox(height: 10),
              Text(
                "Phone Number",
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
              const SizedBox(height: 10),
              Text("Gender",
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
              const SizedBox(height: 10),
              DropdownButtonFormField2<String>(
                  hint: Text(
                    "Gender",
                    style: LIGHT_BROWN_TEXT_STYLE.copyWith(fontSize: 14),
                  ),
                  isExpanded: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                  validator: (value) {
                    if (value == null) {
                      return 'Gender wajib diisi!';
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
                        child: Text(e, style: const TextStyle(fontSize: 14)));
                  }).toList()),
              const SizedBox(height: 10),
              Text(
                "Password",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_isObscure,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password tidak boleh kosong!';
                    }
                    return null;
                  },
                  suffixIcon: IconSuffixButton(
                    isObscure: _isObscure,
                    onPressed: () {
                      setState(
                        () {
                          _isObscure = !_isObscure;
                        },
                      );
                    },
                  ),
                  onFieldSubmitted: (value) {}),
              const SizedBox(height: 40),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoading) {
                    const LoaderIndicator();
                  } else if (state is RegisterSuccess) {
                    showToast(
                        text: "Akun Anda berhasil dibuat! Silahkan Login!",
                        state: ToastStates.SUCCESS);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  } else if (state is RegisterError) {
                    showToast(
                        text: state.registError, state: ToastStates.ERROR);
                  }
                },
                builder: (context, state) {
                  final logCubit = context.read<RegisterCubit>();
                  return logCubit.isRegist
                      ? LoadingButton(onPressed: () {
                          debugPrint('response loading');
                        })
                      : PrimaryButton(
                          text: "Masuk",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              RegisterRequest payload = RegisterRequest(
                                  name: _usernameController.text,
                                  phoneNumber: _phoneController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  genderId:
                                      _genderOption == 'Laki-laki' ? '1' : '2');
                              debugPrint(payload.genderId);
                              await context
                                  .read<RegisterCubit>()
                                  .credsRegist(payload, context);
                            }
                          });
                },
              ),
            ],
          ),
        ));
  }
}
