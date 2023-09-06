import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/customize_text_field.dart';
import 'package:katarasa/widgets/general/icon_suffix.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool _isObscure = false;
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
              PrimaryButton(text: "Simpan", onPressed: () async {})
            ],
          ),
        ),
      )),
    );
  }
}
