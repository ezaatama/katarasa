import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/profile/ubah_password/ubah_password_cubit.dart';
import 'package:katarasa/models/profile/ubah_password/ubah_password_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/loading_button.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/customize_text_field.dart';
import 'package:katarasa/widgets/general/icon_suffix.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool _isObscure = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
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
          "Ubah Password",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                    controller: _passwordController,
                    hintText: "Password Baru",
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
                const SizedBox(height: 30),
                BlocConsumer<UbahPasswordCubit, UbahPasswordState>(
                  listener: (context, state) {
                    if (state is UbahPasswordSuccess) {
                      showToast(
                          text: state.updatePassSuccess,
                          state: ToastStates.SUCCESS);
                      Navigator.pushReplacementNamed(context, '/home');
                    } else if (state is UbahPasswordError) {
                      showToast(
                          text: state.errUpdatePass, state: ToastStates.ERROR);
                    }
                  },
                  builder: (context, state) {
                    var cubit = context.read<UbahPasswordCubit>();
                    return cubit.isUpdatePass
                        ? LoadingButton(onPressed: () {
                            debugPrint('Loading response ubah password');
                          })
                        : PrimaryButton(
                            text: "Simpan",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                UbahPasswordRequest payload =
                                    UbahPasswordRequest(
                                        passwordBaru: _passwordController.text);
                                context
                                    .read<UbahPasswordCubit>()
                                    .updatePassProfile(context, payload);
                              }
                            });
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
