// ignore_for_file: non_constant_identifier_names, constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

class EnvValue {
  static String get SECRET_API => dotenv.get("SECRET_API");
}

class ColorUI {
  static const Color PRIMARY_GREEN = Color(0xFF3B8F51);
  static const Color BACKGROUND_COLOR = Color(0xFFDAE5EC);
  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color BLACK = Color(0xFF000000);
  static const Color GREY = Color(0xFF414042);
  static const Color BROWN = Color(0xFF98613c);
  static const Color MEDIUM_LIGHT_BROWN = Color(0xFFB49A75);
  static const Color MEDIUM_BROWN = Color(0xFF694022);
  static const Color LIGHT_BROWN = Color(0xFFD2B48C);
  static const Color INNER_GRADIENT = Color(0xFFffd363);
  static const Color OUTER_GRADIENT = Color(0xFFfdb933);
  static const Color NAVY = Color(0xFF32415a);
  static const Color SHIMMER_BASE = Color(0xFFE0E0E0);
  static const Color SHIMMER_HIGHLIGHT = Color(0xFFF5F5F5);
  static const Color GREEN_DARK = Color(0xFF41644A);
  static const Color CATEGORY_BG = Color(0xFF1F1E1E);
}

class FontUI {
  static const FontWeight WEIGHT_LIGHT = FontWeight.w400;
  static const FontWeight WEIGHT_MEDIUM = FontWeight.w500;
  static const FontWeight WEIGHT_SEMI_BOLD = FontWeight.w600;
  static const FontWeight WEIGHT_BOLD = FontWeight.w700;
}

TextStyle PRIMARY_TEXT_STYLE = const TextStyle(color: ColorUI.PRIMARY_GREEN);
TextStyle WHITE_TEXT_STYLE = const TextStyle(color: Color(0xFFFFFFFF));
TextStyle BLACK_TEXT_STYLE = const TextStyle(color: ColorUI.BLACK);
TextStyle NAVY_TEXT_STYLE = const TextStyle(color: ColorUI.NAVY);
TextStyle GREY_TEXT_STYLE = const TextStyle(color: ColorUI.GREY);
TextStyle BROWN_TEXT_STYLE = const TextStyle(color: ColorUI.BROWN);
TextStyle LIGHT_BROWN_TEXT_STYLE = const TextStyle(color: ColorUI.LIGHT_BROWN);
TextStyle RED_TEXT_STYLE = const TextStyle(color: Colors.red);

class BorderUI {
  static const double RADIUS_CIRCULAR = 8.0;
  static const double RADIUS_BUTTON = 15.0;
  static const double RADIUS_ROUNDMORE = 40.0;
  static const double RADIUS_ROUNDED = 20.0;
}

List<BoxShadow> containerShadow({
  double blurRadius = 7,
  double spreadRadius = 5,
  Offset offset = const Offset(0, 3),
}) {
  return [
    BoxShadow(
      color: ColorUI.BLACK.withOpacity(0.2),
      spreadRadius: spreadRadius,
      blurRadius: blurRadius,
      offset: offset,
    ),
  ];
}

LinearGradient gradientColor() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEF7E6E),
      Color.fromARGB(255, 230, 63, 37),
      Color.fromARGB(255, 250, 59, 30),
    ],
  );
}

// method
const String GET_METHOD = 'GET';
const String POST_METHOD = 'POST';
const String PATCH_METHOD = 'PATCH';
const String PUT_METHOD = 'PUT';
const String DELETE_METHOD = 'DELETE';

// status code
const int RESPONSE_OK = 200;
const int RESPONSE_OK_NO_CONTENT = 204;
const int RESPONSE_BAD_REQUEST = 400;
const int RESPONSE_UNAUTHORIZED = 401;
const int RESPONSE_FORBIDDEN_ACCESS = 403;
const int RESPONSE_NOT_FOUND = 404;
const int RESPONSE_VALIDATION = 422;
const int RESPONSE_SERVER_ERROR = 500;

List<Widget> notchBottomSheet(String title) {
  return [
    const SizedBox(height: 12.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            title,
            style: BLACK_TEXT_STYLE.copyWith(
                fontSize: 20, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
          ),
        ),
      ],
    ),
    const SizedBox(height: 30.0),
  ];
}

//status caption and color
String parseStatusCaption(String s) {
  switch (s) {
    case 'notPaid':
      return 'Belum Dibayar';
    case 'waitConfirm':
      return 'Menunggu Konfirmasi';
    case 'prepared':
      return 'Disiapkan';
    case 'sent':
      return 'Dikirim';
    case 'done':
      return 'Selesai';
    case 'canceled':
      return 'Dibatalkan';
    case 'refund':
      return 'Pengembalian';
    default:
      return s;
  }
}

Color parseStatusBg(String s) {
  switch (s) {
    case 'notPaid':
      return const Color(0xFFFFF3D2);
    case 'waitConfirm':
      return const Color(0xFFFFCCCC);
    case 'prepared':
      return Color.fromARGB(255, 96, 248, 240);
    case 'sent':
      return const Color.fromARGB(255, 249, 93, 93);
    case 'done':
      return const Color(0xFFB1FFC7);
    case 'canceled':
      return Color.fromARGB(255, 255, 36, 36);
    case 'refund':
      return Color.fromARGB(255, 148, 165, 211);
    default:
      return Colors.blueAccent;
  }
}

Color parseStatusTx(String s) {
  switch (s) {
    case 'notPaid':
      return Color.fromARGB(255, 180, 165, 122);
    case 'waitConfirm':
      return Color.fromARGB(255, 209, 130, 130);
    case 'prepared':
      return Color.fromARGB(255, 36, 158, 152);
    case 'sent':
      return const Color.fromARGB(255, 249, 93, 93);
    case 'done':
      return Color.fromARGB(255, 57, 240, 109);
    case 'canceled':
      return Color.fromARGB(255, 122, 2, 2);
    case 'refund':
      return Color.fromARGB(255, 81, 104, 168);
    default:
      return Colors.white;
  }
}

Future<void> navigateToRedirectUrl(String redirectUrl) async {
  if (!await launchUrl(
    Uri.parse(redirectUrl),
    mode: LaunchMode.externalApplication,
    // mode: LaunchMode.inAppWebView
  )) {
    throw Exception('Could not launch $redirectUrl');
  }
}
