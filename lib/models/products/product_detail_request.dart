class ProductDetailResponse {
  Status status;
  ProductDetailRequest data;

  ProductDetailResponse({
    required this.status,
    required this.data,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponse(
        status: Status.fromJson(json["status"]),
        data: ProductDetailRequest.fromJson(json["data"]),
      );
}

class ProductDetailRequest {
  String id;
  bool isNonPhysical;
  bool isGift;
  bool isWishlist;
  String name;
  String slug;
  String statusProduk;
  Flashsale flashsale;
  List<dynamic> variant;
  String brand;
  String description;
  bool preOrder;
  String masaPengemasan;
  Category category;
  Flashsale subCategory;
  List<String> image;
  String totalSeen;
  String rating;
  String totalReview;
  int amountSold;
  bool isDiscount;
  String discount;
  String price;
  dynamic priceDiscount;
  int stock;
  String weight;
  String condition;
  Store store;
  List<dynamic> review;
  List<OtherProduct> otherProduct;

  ProductDetailRequest({
    required this.id,
    required this.isNonPhysical,
    required this.isGift,
    required this.isWishlist,
    required this.name,
    required this.slug,
    required this.statusProduk,
    required this.flashsale,
    required this.variant,
    required this.brand,
    required this.description,
    required this.preOrder,
    required this.masaPengemasan,
    required this.category,
    required this.subCategory,
    required this.image,
    required this.totalSeen,
    required this.rating,
    required this.totalReview,
    required this.amountSold,
    required this.isDiscount,
    required this.discount,
    required this.price,
    required this.priceDiscount,
    required this.stock,
    required this.weight,
    required this.condition,
    required this.store,
    required this.review,
    required this.otherProduct,
  });

  factory ProductDetailRequest.fromJson(Map<String, dynamic> json) =>
      ProductDetailRequest(
        id: json["id"],
        isNonPhysical: json["isNonPhysical"],
        isGift: json["isGift"],
        isWishlist: json["isWishlist"],
        name: json["name"],
        slug: json["slug"],
        statusProduk: json["statusProduk"],
        flashsale: Flashsale.fromJson(json["flashsale"]),
        variant: List<dynamic>.from(json["variant"].map((x) => x)),
        brand: json["brand"],
        description: json["description"],
        preOrder: json["preOrder"],
        masaPengemasan: json["masaPengemasan"],
        category: Category.fromJson(json["category"]),
        subCategory: Flashsale.fromJson(json["subCategory"]),
        image: List<String>.from(json["image"].map((x) => x)),
        totalSeen: json["totalSeen"],
        rating: json["rating"],
        totalReview: json["totalReview"],
        amountSold: json["amountSold"],
        isDiscount: json["isDiscount"],
        discount: json["discount"],
        price: json["price"],
        priceDiscount: json["priceDiscount"],
        stock: json["stock"],
        weight: json["weight"],
        condition: json["condition"],
        store: Store.fromJson(json["store"]),
        review: List<dynamic>.from(json["review"].map((x) => x)),
        otherProduct: List<OtherProduct>.from(
            json["otherProduct"].map((x) => OtherProduct.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "product_id": id,
        "variant_id": "",
        "qty": 1,
        "isNonPhysical": isNonPhysical
      };
}

class Category {
  String name;
  String slug;

  Category({
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
      };
}

class Flashsale {
  Flashsale();

  factory Flashsale.fromJson(Map<String, dynamic> json) => Flashsale();
}

class OtherProduct {
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

  OtherProduct({
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

  factory OtherProduct.fromJson(Map<String, dynamic> json) => OtherProduct(
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

class Store {
  String id;
  String uid;
  String name;
  String slug;
  String image;
  String location;
  bool closedStore;
  String freeOngkir;

  Store({
    required this.id,
    required this.uid,
    required this.name,
    required this.slug,
    required this.image,
    required this.location,
    required this.closedStore,
    required this.freeOngkir,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        location: json["location"],
        closedStore: json["closed_store"],
        freeOngkir: json["freeOngkir"],
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
