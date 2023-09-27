class SelectShipping {
  String storeId;
  String addressId;
  String shippingCode;
  String shippingTipe;
  String sendTime;

  SelectShipping({
    required this.storeId,
    required this.addressId,
    required this.shippingCode,
    required this.shippingTipe,
    required this.sendTime,
  });

  factory SelectShipping.fromJson(Map<String, dynamic> json) => SelectShipping(
        storeId: json["store_id"],
        addressId: json["address_id"],
        shippingCode: json["shipping_code"],
        shippingTipe: json["shipping_tipe"],
        sendTime: json["send_time"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "address_id": addressId,
        "shipping_code": shippingCode,
        "shipping_tipe": shippingTipe,
        "send_time": sendTime,
      };

  static String shipDesc = '';
  static String shipCurrency = '';
  static String shipEdText = '';
  static int selectedIndex = -1;
  static int selectedType = -1;
  static String selectType = '';
  static String selectItem = '';
  static String selectTime = 'setiap saat';
}
