import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ExtendedNum on num {
  String toRupiah({
    String separator = ',',
    String trailing = "",
    int decimalDigit = 0,
  }) {
    NumberFormat f = NumberFormat.currency(
        locale: 'id_ID', decimalDigits: decimalDigit, symbol: '');
    return f.format(this);
  }
}

//email validator
bool isValidEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

//phone number validator
bool isValidPhoneNumber(String value) {
  String pattern = r'^[0-9]{9,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

void callShowSnackbar(BuildContext context, String msg) {
  final snackBar = SnackBar(content: Text(msg));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
