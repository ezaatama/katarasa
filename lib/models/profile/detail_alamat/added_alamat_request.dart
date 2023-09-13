class AddAlamatRequest {
  final String receiverName;
  final String phoneNumber;
  final String addressAs;
  final String provinceId;
  final String cityId;
  final String districtId;
  final String subDistrictId;
  final String postalCode;
  final String alamatLengkap;

  AddAlamatRequest(
      {required this.receiverName,
      required this.phoneNumber,
      required this.addressAs,
      required this.provinceId,
      required this.cityId,
      required this.districtId,
      required this.subDistrictId,
      required this.postalCode,
      required this.alamatLengkap});

  Map<String, dynamic> toMap() => {
        'receiver_name': receiverName,
        'phone_number': phoneNumber,
        'address_as': addressAs,
        'province_id': provinceId,
        'city_id': cityId,
        'district_id': districtId,
        'sub_district_id': subDistrictId,
        'postal_code': postalCode,
        'alamat_lengkap': alamatLengkap
      };
}
