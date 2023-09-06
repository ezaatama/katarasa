import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/auth/cubit/login_cubit.dart';
import 'package:katarasa/models/auth/login/login_request.dart';
import 'package:katarasa/utils/cache_storage.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/button/loading_button.dart';
import 'package:katarasa/widgets/customize_text_field.dart';
import 'package:katarasa/widgets/general/icon_suffix.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
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
                hintText: "Username",
              ),
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
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    const LoaderIndicator();
                  } else if (state is LoginSuccess) {
                    CacheStorage.setString(
                            key: JWT_TOKEN, value: state.successLogin)
                        .then((value) {
                      initTokenHeader(state.successLogin);

                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    });
                  } else if (state is LoginError) {
                    showToast(text: state.errLogin, state: ToastStates.ERROR);
                  }
                },
                builder: (context, state) {
                  final logCubit = context.read<LoginCubit>();
                  return logCubit.isLogin
                      ? LoadingButton(onPressed: () {
                          debugPrint('response loading');
                        })
                      : PrimaryButton(
                          text: "Masuk",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              LoginRequest payload = LoginRequest(
                                  username: _usernameController.text,
                                  password: _passwordController.text);
                              await context
                                  .read<LoginCubit>()
                                  .credsLogin(payload, context);
                            }
                          });
                },
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum memiliki akun?",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_LIGHT)),
                  TextButton(
                      onPressed: () {
                        debugPrint('Go to register');
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text("Daftar Sekarang",
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontWeight: FontUI.WEIGHT_BOLD)))
                ],
              )
            ],
          ),
        ));
  }
}
