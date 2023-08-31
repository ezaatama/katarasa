class ProductsResponse {
  Status status;
  List<ProductRequest> data;

  ProductsResponse({
    required this.status,
    required this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        status: Status.fromJson(json["status"]),
        data: List<ProductRequest>.from(
            json["data"].map((x) => ProductRequest.fromJson(x))),
      );
}

class ProductRequest {
  String id;
  bool isGift;
  String isPreorder;
  String freeOngkir;
  String name;
  String category;
  String slug;
  String statusProduk;
  String totalSeen;
  bool isDiscount;
  String discount;
  dynamic grade;
  String price;
  dynamic priceDiscount;
  String location;
  String priceLelang;
  String priceDeal;
  dynamic lelangStatus;
  String lelangtType;
  String rating;
  int amountSold;
  String image;

  ProductRequest({
    required this.id,
    required this.isGift,
    required this.isPreorder,
    required this.freeOngkir,
    required this.name,
    required this.category,
    required this.slug,
    required this.statusProduk,
    required this.totalSeen,
    required this.isDiscount,
    required this.discount,
    required this.grade,
    required this.price,
    required this.priceDiscount,
    required this.location,
    required this.priceLelang,
    required this.priceDeal,
    required this.lelangStatus,
    required this.lelangtType,
    required this.rating,
    required this.amountSold,
    required this.image,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
        id: json["id"],
        isGift: json["isGift"],
        isPreorder: json["isPreorder"],
        freeOngkir: json["freeOngkir"],
        name: json["name"],
        category: json["category"],
        slug: json["slug"],
        statusProduk: json["statusProduk"],
        totalSeen: json["totalSeen"],
        isDiscount: json["isDiscount"],
        discount: json["discount"],
        grade: json["grade"],
        price: json["price"],
        priceDiscount: json["priceDiscount"],
        location: json["location"],
        priceLelang: json["priceLelang"],
        priceDeal: json["priceDeal"],
        lelangStatus: json["lelangStatus"],
        lelangtType: json["lelangtType"],
        rating: json["rating"],
        amountSold: json["amountSold"],
        image: json["image"],
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
