class ShippingResponse {
  Status status;
  Shipping data;

  ShippingResponse({
    required this.status,
    required this.data,
  });

  factory ShippingResponse.fromJson(Map<String, dynamic> json) =>
      ShippingResponse(
        status: Status.fromJson(json["status"]),
        data: Shipping.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class Shipping {
  Store store;
  String addressId;
  List<Item> items;
  int totalWeight;
  List<SendTime> sendTime;

  Shipping({
    required this.store,
    required this.addressId,
    required this.items,
    required this.totalWeight,
    required this.sendTime,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        store: Store.fromJson(json["store"]),
        addressId: json["addressId"] ?? "",
        items:
            List<Item>.from((json["items"] ?? []).map((x) => Item.fromJson(x))),
        totalWeight: json["totalWeight"] ?? 0,
        sendTime: List<SendTime>.from(
            (json["sendTime"] ?? []).map((x) => SendTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "store": store.toJson(),
        "addressId": addressId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalWeight": totalWeight,
        "sendTime": List<dynamic>.from(sendTime.map((x) => x.toJson())),
      };
}

class Item {
  String code;
  bool isSelected;
  String name;
  String icon;
  List<Type> type;

  Item({
    required this.code,
    required this.isSelected,
    required this.name,
    required this.icon,
    required this.type,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        code: json["code"],
        isSelected: json["isSelected"],
        name: json["name"],
        icon: json["icon"],
        type: List<Type>.from(json["type"].map((x) => Type.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "isSelected": isSelected,
        "name": name,
        "icon": icon,
        "type": List<dynamic>.from(type.map((x) => x.toJson())),
      };
}

class Type {
  String code;
  bool isSelected;
  String name;
  dynamic price;
  String priceCurrencyFormat;
  String etd;
  String etdText;

  Type({
    required this.code,
    required this.isSelected,
    required this.name,
    required this.price,
    required this.priceCurrencyFormat,
    required this.etd,
    required this.etdText,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        code: json["code"],
        isSelected: json["isSelected"],
        name: json["name"],
        price: json["price"],
        priceCurrencyFormat: json["priceCurrencyFormat"],
        etd: json["etd"],
        etdText: json["etdText"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "isSelected": isSelected,
        "name": name,
        "price": price,
        "priceCurrencyFormat": priceCurrencyFormat,
        "etd": etd,
        "etdText": etdText,
      };
}

class SendTime {
  String name;
  bool isSelected;
  String value;
  String description;

  SendTime({
    required this.name,
    required this.isSelected,
    required this.value,
    required this.description,
  });

  factory SendTime.fromJson(Map<String, dynamic> json) => SendTime(
        name: json["name"],
        isSelected: json["isSelected"],
        value: json["value"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isSelected": isSelected,
        "value": value,
        "description": description,
      };
}

class Store {
  String id;
  String name;
  String slug;
  String image;
  String location;
  String freeOngkir;
  int minFreeOngkir;

  Store({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.location,
    required this.freeOngkir,
    required this.minFreeOngkir,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        location: json["location"],
        freeOngkir: json["free_ongkir"],
        minFreeOngkir: json["min_free_ongkir"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "location": location,
        "free_ongkir": freeOngkir,
        "min_free_ongkir": minFreeOngkir,
      };
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
