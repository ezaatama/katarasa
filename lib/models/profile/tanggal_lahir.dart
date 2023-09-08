import 'package:flutter/material.dart';

class TanggalLahir {
  //controller for save value
  static final TextEditingController dateController = TextEditingController();
  static final TextEditingController monthController = TextEditingController();
  static final TextEditingController yearController = TextEditingController();

  static bool onError = false;
  static int? dateBirthDay;
  static var dateBirthMonth;
  static int? dateBirthYear;
  static var n = DateTime.now().year;
  static var t = DateTime.now().day;

  //join date of birth
  static final dateBirth = "$dateBirthYear-$dateBirthMonth-$dateBirthDay";

  //checking validate day-month
  static final checkDayMonth = "$dateBirthMonth-$dateBirthYear";

  //check leap year
  static int daysInMonth(int month, int year) {
    int days = 28 +
        (month + (month / 8).floor()) % 2 +
        2 % month +
        2 * (1 / month).floor();
    return (isLeapYear(year) && month == 2) ? 29 : days;
  }

  //declare leap year
  static bool isLeapYear(int year) =>
      ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);

  //list of months
  static List<dynamic> listMonths = [
    {"id": 01, "value": "January"},
    {"id": 02, "value": "February"},
    {"id": 03, "value": "March"},
    {"id": 04, "value": "April"},
    {"id": 05, "value": "May"},
    {"id": 06, "value": "June"},
    {"id": 07, "value": "July"},
    {"id": 08, "value": "August"},
    {"id": 09, "value": "September"},
    {"id": 10, "value": "October"},
    {"id": 11, "value": "November"},
    {"id": 12, "value": "December"}
  ];
}
