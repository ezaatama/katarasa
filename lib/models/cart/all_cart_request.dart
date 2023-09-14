class AllCartRequest {
  Status status;
  AllCart data;

  AllCartRequest({
    required this.status,
    required this.data,
  });

  factory AllCartRequest.fromJson(Map<String, dynamic> json) => AllCartRequest(
        status: Status.fromJson(json["status"]),
        data: AllCart.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class AllCart {
  int page;
  int limit;
  dynamic totalProductSelected;
  int totalData;
  int totalPage;
  int totalCart;
  String totalCartCurrencyFormat;
  bool isHasAddress;
  List<Item> items;

  AllCart({
    required this.page,
    required this.limit,
    required this.totalProductSelected,
    required this.totalData,
    required this.totalPage,
    required this.totalCart,
    required this.totalCartCurrencyFormat,
    required this.isHasAddress,
    required this.items,
  });

  factory AllCart.fromJson(Map<String, dynamic> json) => AllCart(
        page: json["page"],
        limit: json["limit"],
        totalProductSelected: json["totalProductSelected"],
        totalData: json["totalData"],
        totalPage: json["totalPage"],
        totalCart: json["totalCart"],
        totalCartCurrencyFormat: json["totalCartCurrencyFormat"],
        isHasAddress: json["isHasAddress"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "totalProductSelected": totalProductSelected,
        "totalData": totalData,
        "totalPage": totalPage,
        "totalCart": totalCart,
        "totalCartCurrencyFormat": totalCartCurrencyFormat,
        "isHasAddress": isHasAddress,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  bool isSelected;
  Store store;
  List<ProductCart> products;

  Item({
    required this.isSelected,
    required this.store,
    required this.products,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        isSelected: json["isSelected"],
        store: Store.fromJson(json["store"]),
        products: List<ProductCart>.from(
            json["products"].map((x) => ProductCart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSelected": isSelected,
        "store": store.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductCart {
  String productId;
  String cartId;
  String variantId;
  bool isGift;
  bool isSelected;
  String name;
  dynamic greetingCardGift;
  String slug;
  String image;
  List<dynamic> badges;
  String stockRemaining;
  dynamic variant;
  String qty;
  bool isDiscount;
  String discount;
  String price;
  String priceCurrencyFormat;
  dynamic priceDiscount;
  dynamic priceDiscountCurrencyFormat;
  int subTotal;
  String subTotalCurrencyFormat;

  ProductCart({
    required this.productId,
    required this.cartId,
    required this.variantId,
    required this.isGift,
    this.isSelected = false,
    required this.name,
    required this.greetingCardGift,
    required this.slug,
    required this.image,
    required this.badges,
    required this.stockRemaining,
    required this.variant,
    required this.qty,
    required this.isDiscount,
    required this.discount,
    required this.price,
    required this.priceCurrencyFormat,
    required this.priceDiscount,
    required this.priceDiscountCurrencyFormat,
    required this.subTotal,
    required this.subTotalCurrencyFormat,
  });

  ProductCart copyWith(
      {String? productId,
      String? cartId,
      String? variantId,
      bool? isGift,
      bool? isSelected,
      String? name,
      dynamic greetingCardGift,
      String? slug,
      String? image,
      List<dynamic>? badges,
      String? stockRemaining,
      dynamic variant,
      String? qty,
      bool? isDiscount,
      String? discount,
      String? price,
      String? priceCurrencyFormat,
      dynamic priceDiscount,
      dynamic priceDiscountCurrencyFormat,
      int? subTotal,
      String? subTotalCurrencyFormat}) {
    return ProductCart(
        productId: productId ?? this.productId,
        cartId: cartId ?? this.cartId,
        variantId: variantId ?? this.variantId,
        isGift: isGift ?? this.isGift,
        isSelected: isSelected ?? this.isSelected,
        name: name ?? this.name,
        greetingCardGift: greetingCardGift ?? this.greetingCardGift,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        badges: badges ?? this.badges,
        stockRemaining: stockRemaining ?? this.stockRemaining,
        variant: variant ?? this.variant,
        qty: qty ?? this.qty,
        discount: discount ?? this.discount,
        isDiscount: isDiscount ?? this.isDiscount,
        price: price ?? this.price,
        priceCurrencyFormat: priceCurrencyFormat ?? this.priceCurrencyFormat,
        priceDiscount: priceDiscount ?? this.priceDiscount,
        priceDiscountCurrencyFormat:
            priceDiscountCurrencyFormat ?? this.priceDiscountCurrencyFormat,
        subTotal: subTotal ?? this.subTotal,
        subTotalCurrencyFormat:
            subTotalCurrencyFormat ?? this.subTotalCurrencyFormat);
  }

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
        productId: json["productId"],
        cartId: json["cartId"],
        variantId: json["variantId"],
        isGift: json["isGift"],
        isSelected: json["isSelected"],
        name: json["name"],
        greetingCardGift: json["greetingCardGift"],
        slug: json["slug"],
        image: json["image"],
        badges: List<dynamic>.from(json["badges"].map((x) => x)),
        stockRemaining: json["stockRemaining"],
        variant: json["variant"],
        qty: json["qty"],
        isDiscount: json["isDiscount"],
        discount: json["discount"],
        price: json["price"],
        priceCurrencyFormat: json["priceCurrencyFormat"],
        priceDiscount: json["priceDiscount"],
        priceDiscountCurrencyFormat: json["priceDiscountCurrencyFormat"],
        subTotal: json["subTotal"],
        subTotalCurrencyFormat: json["subTotalCurrencyFormat"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "cartId": cartId,
        "variantId": variantId,
        "isGift": isGift,
        "isSelected": isSelected,
        "name": name,
        "greetingCardGift": greetingCardGift,
        "slug": slug,
        "image": image,
        "badges": List<dynamic>.from(badges.map((x) => x)),
        "stockRemaining": stockRemaining,
        "variant": variant,
        "qty": qty,
        "isDiscount": isDiscount,
        "discount": discount,
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
  String slug;
  String image;
  String location;

  Store({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.location,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
