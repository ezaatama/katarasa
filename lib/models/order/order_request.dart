class DataOrderResponse {
  Status status;
  DataOrder data;

  DataOrderResponse({
    required this.status,
    required this.data,
  });

  factory DataOrderResponse.fromJson(Map<String, dynamic> json) =>
      DataOrderResponse(
        status: Status.fromJson(json["status"]),
        data: DataOrder.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DataOrder {
  int page;
  int limit;
  int totalData;
  int totalPage;
  List<DataItem> items;
  List<Filter> filters;

  DataOrder({
    required this.page,
    required this.limit,
    required this.totalData,
    required this.totalPage,
    required this.items,
    required this.filters,
  });

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
        page: json["page"],
        limit: json["limit"],
        totalData: json["totalData"],
        totalPage: json["totalPage"],
        items:
            List<DataItem>.from(json["items"].map((x) => DataItem.fromJson(x))),
        filters:
            List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "totalData": totalData,
        "totalPage": totalPage,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
      };
}

class Filter {
  String title;
  String value;
  int total;
  bool inActive;

  Filter({
    required this.title,
    required this.value,
    required this.total,
    required this.inActive,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        title: json["title"],
        value: json["value"],
        total: json["total"],
        inActive: json["inActive"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
        "total": total,
        "inActive": inActive,
      };
}

class DataItem {
  String orderId;
  bool isGift;
  bool isCancel;
  dynamic cancelBy;
  String createdAt;
  String expiredAt;
  String totalPrice;
  String totalPriceCurrencyFormat;
  int totalOtherProduct;
  List<ItemItem> items;

  DataItem({
    required this.orderId,
    required this.isGift,
    required this.isCancel,
    required this.cancelBy,
    required this.createdAt,
    required this.expiredAt,
    required this.totalPrice,
    required this.totalPriceCurrencyFormat,
    required this.totalOtherProduct,
    required this.items,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        orderId: json["orderId"],
        isGift: json["isGift"],
        isCancel: json["isCancel"],
        cancelBy: json["cancelBy"],
        createdAt: json["createdAt"],
        expiredAt: json["expiredAt"],
        totalPrice: json["totalPrice"],
        totalPriceCurrencyFormat: json["totalPriceCurrencyFormat"],
        totalOtherProduct: json["totalOtherProduct"],
        items:
            List<ItemItem>.from(json["items"].map((x) => ItemItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "isGift": isGift,
        "isCancel": isCancel,
        "cancelBy": cancelBy,
        "createdAt": createdAt,
        "expiredAt": expiredAt,
        "totalPrice": totalPrice,
        "totalPriceCurrencyFormat": totalPriceCurrencyFormat,
        "totalOtherProduct": totalOtherProduct,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ItemItem {
  String invoice;
  bool isRating;
  Store store;
  List<Product> products;

  ItemItem({
    required this.invoice,
    required this.isRating,
    required this.store,
    required this.products,
  });

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
        invoice: json["invoice"],
        isRating: json["isRating"],
        store: Store.fromJson(json["store"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoice": invoice,
        "isRating": isRating,
        "store": store.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String name;
  String slug;
  String image;
  dynamic variant;
  List<dynamic> badges;
  String qty;
  bool isDiscount;
  String price;
  String priceCurrencyFormat;
  dynamic priceDiscount;
  dynamic priceDiscountCurrencyFormat;
  int subTotal;
  String subTotalCurrencyFormat;

  Product({
    required this.name,
    required this.slug,
    required this.image,
    required this.variant,
    required this.badges,
    required this.qty,
    required this.isDiscount,
    required this.price,
    required this.priceCurrencyFormat,
    required this.priceDiscount,
    required this.priceDiscountCurrencyFormat,
    required this.subTotal,
    required this.subTotalCurrencyFormat,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        variant: json["variant"],
        badges: List<dynamic>.from(json["badges"].map((x) => x)),
        qty: json["qty"],
        isDiscount: json["isDiscount"],
        price: json["price"],
        priceCurrencyFormat: json["priceCurrencyFormat"],
        priceDiscount: json["priceDiscount"],
        priceDiscountCurrencyFormat: json["priceDiscountCurrencyFormat"],
        subTotal: json["subTotal"],
        subTotalCurrencyFormat: json["subTotalCurrencyFormat"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "image": image,
        "variant": variant,
        "badges": List<dynamic>.from(badges.map((x) => x)),
        "qty": qty,
        "isDiscount": isDiscount,
        "price": price,
        "priceCurrencyFormat": priceCurrencyFormat,
        "priceDiscount": priceDiscount,
        "priceDiscountCurrencyFormat": priceDiscountCurrencyFormat,
        "subTotal": subTotal,
        "subTotalCurrencyFormat": subTotalCurrencyFormat,
      };
}

class Store {
  String id;
  String name;
  String uid;
  String slug;
  String image;
  String location;

  Store({
    required this.id,
    required this.name,
    required this.uid,
    required this.slug,
    required this.image,
    required this.location,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        uid: json["uid"],
        slug: json["slug"],
        image: json["image"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "uid": uid,
        "slug": slug,
        "image": image,
        "location": location,
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
