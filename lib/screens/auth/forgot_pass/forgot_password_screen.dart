import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/auth/forgot_pass/forgot_pass_cubit.dart';
import 'package:katarasa/models/auth/forgot_pass/forgot_password_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/button/loading_button.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/customize_text_field.dart';
import 'package:katarasa/widgets/general/icon_suffix.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isObscure = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

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
          "Lupa Password",
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Email Terdaftar",
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
              "Password Baru",
              style: BLACK_TEXT_STYLE.copyWith(
                  fontWeight: FontUI.WEIGHT_SEMI_BOLD),
            ),
            const SizedBox(height: 10),
            CustomTextField(
                controller: _newPassController,
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
            const SizedBox(height: 40),
            BlocConsumer<ForgotPassCubit, ForgotPassState>(
              listener: (context, state) {
                if (state is ForgotPassLoading) {
                  const LoaderIndicator();
                } else if (state is ForgotPassSuccess) {
                  showToast(
                      text: state.forgotPassSuccess,
                      state: ToastStates.SUCCESS);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                } else if (state is ForgotPassError) {
                  showToast(
                      text: state.forgotPassErr, state: ToastStates.ERROR);
                }
              },
              builder: (context, state) {
                final logCubit = context.read<ForgotPassCubit>();
                return logCubit.isForgot
                    ? LoadingButton(onPressed: () {
                        debugPrint('response loading');
                      })
                    : PrimaryButton(
                        text: "Kirim",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ForgotPasswordRequest payload =
                                ForgotPasswordRequest(
                                    email: _emailController.text,
                                    newPass: _newPassController.text);
                            await context
                                .read<ForgotPassCubit>()
                                .credsForgotPass(payload, context);
                          }
                        });
              },
            ),
          ],
        ),
      ),
    );
  }
}
