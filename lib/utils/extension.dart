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

void callShowSnackbar(BuildContext context, String msg) {
  final snackBar = SnackBar(content: Text(msg));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
