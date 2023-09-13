class DetailAlamatRequest {
  Status status;
  List<DetailAlamat> data;

  DetailAlamatRequest({
    required this.status,
    required this.data,
  });

  factory DetailAlamatRequest.fromJson(Map<String, dynamic> json) =>
      DetailAlamatRequest(
        status: Status.fromJson(json["status"]),
        data: List<DetailAlamat>.from(
            json["data"].map((x) => DetailAlamat.fromJson(x))),
      );

  static final List<String> namaAlamat = ["Rumah", "Kantor"];
}

class DetailAlamat {
  int id;
  int customerId;
  String addressAs;
  String receiverName;
  String phoneNumber;
  String completeAddress;
  String postalCode;
  Province province;
  City city;
  District district;
  SubDistrict subDistrict;

  DetailAlamat({
    required this.id,
    required this.customerId,
    required this.addressAs,
    required this.receiverName,
    required this.phoneNumber,
    required this.completeAddress,
    required this.postalCode,
    required this.province,
    required this.city,
    required this.district,
    required this.subDistrict,
  });

  factory DetailAlamat.fromJson(Map<String, dynamic> json) => DetailAlamat(
        id: json["id"],
        customerId: json["customer_id"],
        addressAs: json["address_as"],
        receiverName: json["receiver_name"],
        phoneNumber: json["phone_number"],
        completeAddress: json["complete_address"],
        postalCode: json["postal_code"],
        province: Province.fromJson(json["province"]),
        city: City.fromJson(json["city"]),
        district: District.fromJson(json["district"]),
        subDistrict: SubDistrict.fromJson(json["sub_district"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "address_as": addressAs,
        "receiver_name": receiverName,
        "phone_number": phoneNumber,
        "complete_address": completeAddress,
        "postal_code": postalCode,
        "province": province.toJson(),
        "city": city.toJson(),
        "district": district.toJson(),
        "sub_district": subDistrict.toJson(),
      };
}

class Province {
  int id;
  String name;

  Province({
    required this.id,
    required this.name,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class City extends Province {
  City({required id, required name}) : super(id: id, name: name);

  @override
  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
      );
}

class District extends Province {
  District({required id, required name}) : super(id: id, name: name);

  @override
  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
      );
}

class SubDistrict extends Province {
  SubDistrict({required id, required name}) : super(id: id, name: name);

  @override
  factory SubDistrict.fromJson(Map<String, dynamic> json) => SubDistrict(
        id: json["id"],
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

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
