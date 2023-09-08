class DataProfileRequest {
  String name;
  String? nip;
  String? corporate;
  String? department;
  String birthDate;
  String phoneNumber;
  String email;
  String genderId;

  DataProfileRequest({
    required this.name,
    this.nip,
    this.corporate,
    this.department,
    required this.birthDate,
    required this.phoneNumber,
    required this.email,
    required this.genderId,
  });

  factory DataProfileRequest.fromJson(Map<String, dynamic> json) =>
      DataProfileRequest(
        name: json["name"],
        nip: json["nip"],
        corporate: json["corporate"],
        department: json["department"],
        birthDate: json["birth_date"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        genderId: json["gender_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nip": nip,
        "corporate": corporate,
        "department": department,
        "birth_date": birthDate,
        "phone_number": phoneNumber,
        "email": email,
        "gender_id": genderId,
      };
}

class UpdateProfileRequest {
  String namaLengkap;
  String? nip;
  String? corporate;
  String? department;
  String tanggalLahir;
  String phoneNumber;
  String genderId;

  UpdateProfileRequest({
    required this.namaLengkap,
    this.nip,
    this.corporate,
    this.department,
    required this.tanggalLahir,
    required this.phoneNumber,
    required this.genderId,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        namaLengkap: json["namaLengkap"],
        nip: json["nip"] ?? "",
        corporate: json["corporate"] ?? "",
        department: json["department"] ?? "",
        tanggalLahir: json["tanggalLahir"],
        phoneNumber: json["phoneNumber"],
        genderId: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "namaLengkap": namaLengkap,
        "nip": nip,
        "corporate": corporate,
        "department": department,
        "tanggalLahir": tanggalLahir,
        "phoneNumber": phoneNumber,
        "gender": genderId,
      };
}
