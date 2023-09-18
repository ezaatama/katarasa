// ignore_for_file: override_on_non_overriding_member, must_be_immutable

import 'package:equatable/equatable.dart';

class AlamatRequest {
  Status status;
  DataAlamat data;

  AlamatRequest({
    required this.status,
    required this.data,
  });

  factory AlamatRequest.fromJson(Map<String, dynamic> json) => AlamatRequest(
        status: Status.fromJson(json["status"]),
        data: DataAlamat.fromJson(json["data"]),
      );
}

class DataAlamat {
  List<SelectProvinsi> selectProvinsi;
  List<SelectKota> selectKota;
  List<SelectKabupaten> selectKabupaten;
  List<SelectKecamatan> selectKecamatan;

  DataAlamat({
    required this.selectProvinsi,
    required this.selectKota,
    required this.selectKabupaten,
    required this.selectKecamatan,
  });

  factory DataAlamat.fromJson(Map<String, dynamic> json) => DataAlamat(
        selectProvinsi: List<SelectProvinsi>.from(
            json["selectProvinsi"].map((x) => SelectProvinsi.fromJson(x))),
        selectKota: List<SelectKota>.from(
            json["selectKota"].map((x) => SelectKota.fromJson(x))),
        selectKabupaten: List<SelectKabupaten>.from(
            json["selectKabupaten"].map((x) => SelectKabupaten.fromJson(x))),
        selectKecamatan: List<SelectKecamatan>.from(
            json["selectKecamatan"].map((x) => SelectKecamatan.fromJson(x))),
      );
}

class SelectKabupaten {
  int districtId;
  String name;
  String districtKd;

  SelectKabupaten({
    required this.districtId,
    required this.name,
    required this.districtKd,
  });

  @override
  List<Object> get props => [districtId, name, districtKd];

  factory SelectKabupaten.fromJson(Map<String, dynamic> json) =>
      SelectKabupaten(
        districtId: json["district_id"],
        name: json["name"],
        districtKd: json["district_kd"],
      );
}

class SelectKecamatan {
  int subDistrictId;
  String name;
  String subDistrictKd;

  SelectKecamatan({
    required this.subDistrictId,
    required this.name,
    required this.subDistrictKd,
  });

  @override
  List<Object> get props => [subDistrictId, name, subDistrictKd];

  factory SelectKecamatan.fromJson(Map<String, dynamic> json) =>
      SelectKecamatan(
        subDistrictId: json["sub_district_id"],
        name: json["name"],
        subDistrictKd: json["sub_district_kd"],
      );
}

class SelectKota {
  int cityId;
  String name;

  SelectKota({
    required this.cityId,
    required this.name,
  });

  @override
  List<Object> get props => [cityId, name];

  factory SelectKota.fromJson(Map<String, dynamic> json) => SelectKota(
        cityId: json["city_id"],
        name: json["name"],
      );
}

class SelectProvinsi extends Equatable {
  int provinceId;
  String name;

  SelectProvinsi({
    required this.provinceId,
    required this.name,
  });

  @override
  List<Object> get props => [provinceId, name];

  factory SelectProvinsi.fromJson(Map<String, dynamic> json) => SelectProvinsi(
        provinceId: json["province_id"],
        name: json["name"],
      );
}

class Status {
  int code;
  String message;

  Status({
    required this.code,
    required this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
      );
}
