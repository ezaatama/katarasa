// To parse this JSON data, do
//
//     final checkoutResponse = checkoutResponseFromJson(jsonString);

import 'dart:convert';

CheckoutResponse checkoutResponseFromJson(String str) =>
    CheckoutResponse.fromJson(json.decode(str));

String checkoutResponseToJson(CheckoutResponse data) =>
    json.encode(data.toJson());

class CheckoutResponse {
  Status status;
  Checkout data;

  CheckoutResponse({
    required this.status,
    required this.data,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      CheckoutResponse(
        status: Status.fromJson(json["status"]),
        data: Checkout.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class Checkout {
  bool isCoin;
  bool isNonPhysical;
  bool isGift;
  int totalAllProduct;
  List<dynamic> voucherJajaSelected;
  List<VoucherJaja> voucherJaja;
  int subTotal;
  String subTotalCurrencyFormat;
  int shippingCost;
  String shippingCostCurrencyFormat;
  int voucherDiscountJaja;
  String voucherDiscountJajaCurrencyFormat;
  String voucherDiscountJajaDesc;
  String voucherJajaType;
  int coinRemaining;
  String coinRemainingFormat;
  int coinUsed;
  String coinUsedFormat;
  int total;
  String totalCurrencyFormat;
  Address address;
  List<Cart> cart;

  Checkout({
    required this.isCoin,
    required this.isNonPhysical,
    required this.isGift,
    required this.totalAllProduct,
    required this.voucherJajaSelected,
    required this.voucherJaja,
    required this.subTotal,
    required this.subTotalCurrencyFormat,
    required this.shippingCost,
    required this.shippingCostCurrencyFormat,
    required this.voucherDiscountJaja,
    required this.voucherDiscountJajaCurrencyFormat,
    required this.voucherDiscountJajaDesc,
    required this.voucherJajaType,
    required this.coinRemaining,
    required this.coinRemainingFormat,
    required this.coinUsed,
    required this.coinUsedFormat,
    required this.total,
    required this.totalCurrencyFormat,
    required this.address,
    required this.cart,
  });

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
        isCoin: json["isCoin"],
        isNonPhysical: json["is_non_physical"],
        isGift: json["isGift"],
        totalAllProduct: json["totalAllProduct"],
        voucherJajaSelected:
            List<dynamic>.from(json["voucherJajaSelected"].map((x) => x)),
        voucherJaja: List<VoucherJaja>.from(
            json["voucherJaja"].map((x) => VoucherJaja.fromJson(x))),
        subTotal: json["subTotal"],
        subTotalCurrencyFormat: json["subTotalCurrencyFormat"],
        shippingCost: json["shippingCost"],
        shippingCostCurrencyFormat: json["shippingCostCurrencyFormat"],
        voucherDiscountJaja: json["voucherDiscountJaja"],
        voucherDiscountJajaCurrencyFormat:
            json["voucherDiscountJajaCurrencyFormat"],
        voucherDiscountJajaDesc: json["voucherDiscountJajaDesc"],
        voucherJajaType: json["voucherJajaType"],
        coinRemaining: json["coinRemaining"],
        coinRemainingFormat: json["coinRemainingFormat"],
        coinUsed: json["coinUsed"],
        coinUsedFormat: json["coinUsedFormat"],
        total: json["total"],
        totalCurrencyFormat: json["totalCurrencyFormat"],
        address: Address.fromJson(json["address"]),
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isCoin": isCoin,
        "is_non_physical": isNonPhysical,
        "isGift": isGift,
        "totalAllProduct": totalAllProduct,
        "voucherJajaSelected":
            List<dynamic>.from(voucherJajaSelected.map((x) => x)),
        "voucherJaja": List<dynamic>.from(voucherJaja.map((x) => x.toJson())),
        "subTotal": subTotal,
        "subTotalCurrencyFormat": subTotalCurrencyFormat,
        "shippingCost": shippingCost,
        "shippingCostCurrencyFormat": shippingCostCurrencyFormat,
        "voucherDiscountJaja": voucherDiscountJaja,
        "voucherDiscountJajaCurrencyFormat": voucherDiscountJajaCurrencyFormat,
        "voucherDiscountJajaDesc": voucherDiscountJajaDesc,
        "voucherJajaType": voucherJajaType,
        "coinRemaining": coinRemaining,
        "coinRemainingFormat": coinRemainingFormat,
        "coinUsed": coinUsed,
        "coinUsedFormat": coinUsedFormat,
        "total": total,
        "totalCurrencyFormat": totalCurrencyFormat,
        "address": address.toJson(),
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
      };
}

class Address {
  String label;
  String receiverName;
  String phoneNumber;
  String address;
  String postalCode;
  String latitude;
  String longitude;

  Address({
    required this.label,
    required this.receiverName,
    required this.phoneNumber,
    required this.address,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        label: json["label"],
        receiverName: json["receiverName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        postalCode: json["postalCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "receiverName": receiverName,
        "phoneNumber": phoneNumber,
        "address": address,
        "postalCode": postalCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Cart {
  int voucherDiscount;
  String voucherDiscountCurrencyFormat;
  int total;
  String totalCurrencyFormat;
  int totalDiscount;
  String totalDiscountCurrencyFormat;
  int totalWeight;
  Store store;
  String totalBelanja;
  ShippingSelected shippingSelected;
  VoucherStoreSelected voucherStoreSelected;
  List<dynamic> voucherStore;
  List<Product> products;

  Cart({
    required this.voucherDiscount,
    required this.voucherDiscountCurrencyFormat,
    required this.total,
    required this.totalCurrencyFormat,
    required this.totalDiscount,
    required this.totalDiscountCurrencyFormat,
    required this.totalWeight,
    required this.store,
    required this.totalBelanja,
    required this.shippingSelected,
    required this.voucherStoreSelected,
    required this.voucherStore,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        voucherDiscount: json["voucherDiscount"],
        voucherDiscountCurrencyFormat: json["voucherDiscountCurrencyFormat"],
        total: json["total"],
        totalCurrencyFormat: json["totalCurrencyFormat"],
        totalDiscount: json["totalDiscount"],
        totalDiscountCurrencyFormat: json["totalDiscountCurrencyFormat"],
        totalWeight: json["totalWeight"],
        store: Store.fromJson(json["store"]),
        totalBelanja: json["totalBelanja"],
        shippingSelected: ShippingSelected.fromJson(json["shippingSelected"]),
        voucherStoreSelected:
            VoucherStoreSelected.fromJson(json["voucherStoreSelected"]),
        voucherStore: List<dynamic>.from(json["voucherStore"].map((x) => x)),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "voucherDiscount": voucherDiscount,
        "voucherDiscountCurrencyFormat": voucherDiscountCurrencyFormat,
        "total": total,
        "totalCurrencyFormat": totalCurrencyFormat,
        "totalDiscount": totalDiscount,
        "totalDiscountCurrencyFormat": totalDiscountCurrencyFormat,
        "totalWeight": totalWeight,
        "store": store.toJson(),
        "totalBelanja": totalBelanja,
        "shippingSelected": shippingSelected.toJson(),
        "voucherStoreSelected": voucherStoreSelected.toJson(),
        "voucherStore": List<dynamic>.from(voucherStore.map((x) => x)),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String productId;
  String variantId;
  String cartId;
  String name;
  dynamic greetingCardGift;
  String slug;
  String image;
  String description;
  List<dynamic> badges;
  String stockRemaining;
  dynamic variant;
  String qty;
  int weight;
  bool isDiscount;
  String discount;
  String price;
  String priceCurrencyFormat;
  dynamic priceDiscount;
  dynamic priceDiscountCurrencyFormat;
  bool isUseVoucher;
  int subTotal;
  String subTotalCurrencyFormat;

  Product({
    required this.productId,
    required this.variantId,
    required this.cartId,
    required this.name,
    required this.greetingCardGift,
    required this.slug,
    required this.image,
    required this.description,
    required this.badges,
    required this.stockRemaining,
    required this.variant,
    required this.qty,
    required this.weight,
    required this.isDiscount,
    required this.discount,
    required this.price,
    required this.priceCurrencyFormat,
    required this.priceDiscount,
    required this.priceDiscountCurrencyFormat,
    required this.isUseVoucher,
    required this.subTotal,
    required this.subTotalCurrencyFormat,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        variantId: json["variantId"],
        cartId: json["cartId"],
        name: json["name"],
        greetingCardGift: json["greetingCardGift"],
        slug: json["slug"],
        image: json["image"],
        description: json["description"],
        badges: List<dynamic>.from(json["badges"].map((x) => x)),
        stockRemaining: json["stockRemaining"],
        variant: json["variant"],
        qty: json["qty"],
        weight: json["weight"],
        isDiscount: json["isDiscount"],
        discount: json["discount"],
        price: json["price"],
        priceCurrencyFormat: json["priceCurrencyFormat"],
        priceDiscount: json["priceDiscount"],
        priceDiscountCurrencyFormat: json["priceDiscountCurrencyFormat"],
        isUseVoucher: json["isUseVoucher"],
        subTotal: json["subTotal"],
        subTotalCurrencyFormat: json["subTotalCurrencyFormat"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "variantId": variantId,
        "cartId": cartId,
        "name": name,
        "greetingCardGift": greetingCardGift,
        "slug": slug,
        "image": image,
        "description": description,
        "badges": List<dynamic>.from(badges.map((x) => x)),
        "stockRemaining": stockRemaining,
        "variant": variant,
        "qty": qty,
        "weight": weight,
        "isDiscount": isDiscount,
        "discount": discount,
        "price": price,
        "priceCurrencyFormat": priceCurrencyFormat,
        "priceDiscount": priceDiscount,
        "priceDiscountCurrencyFormat": priceDiscountCurrencyFormat,
        "isUseVoucher": isUseVoucher,
        "subTotal": subTotal,
        "subTotalCurrencyFormat": subTotalCurrencyFormat,
      };
}

class ShippingSelected {
  String code;
  String type;
  String name;
  String description;
  String price;
  String priceCurrencyFormat;
  String etd;
  String etdText;
  String sendTime;
  String sendTimeText;
  String dateSendTime;

  ShippingSelected({
    required this.code,
    required this.type,
    required this.name,
    required this.description,
    required this.price,
    required this.priceCurrencyFormat,
    required this.etd,
    required this.etdText,
    required this.sendTime,
    required this.sendTimeText,
    required this.dateSendTime,
  });

  factory ShippingSelected.fromJson(Map<String, dynamic> json) =>
      ShippingSelected(
        code: json["code"] ?? "",
        type: json["type"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        price: json["price"] ?? "",
        priceCurrencyFormat: json["priceCurrencyFormat"] ?? "",
        etd: json["etd"] ?? "",
        etdText: json["etdText"] ?? "",
        sendTime: json["sendTime"] ?? "",
        sendTimeText: json["sendTimeText"] ?? "",
        dateSendTime: json["dateSendTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "type": type,
        "name": name,
        "description": description,
        "price": price,
        "priceCurrencyFormat": priceCurrencyFormat,
        "etd": etd,
        "etdText": etdText,
        "sendTime": sendTime,
        "sendTimeText": sendTimeText,
        "dateSendTime": dateSendTime,
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

class VoucherStoreSelected {
  VoucherStoreSelected();

  factory VoucherStoreSelected.fromJson(Map<String, dynamic> json) =>
      VoucherStoreSelected();

  Map<String, dynamic> toJson() => {};
}

class VoucherJaja {
  String id;
  bool isClaimed;
  bool isSelected;
  bool isValid;
  String code;
  String name;
  String image;
  String type;
  String category;
  String quota;
  String minShopping;
  String minShoppingCurrencyFormat;
  int maxShopping;
  String maxShoppingCurrencyFormat;
  bool isDiscountPercent;
  String discount;
  String discountText;
  String startDate;
  String endDate;

  VoucherJaja({
    required this.id,
    required this.isClaimed,
    required this.isSelected,
    required this.isValid,
    required this.code,
    required this.name,
    required this.image,
    required this.type,
    required this.category,
    required this.quota,
    required this.minShopping,
    required this.minShoppingCurrencyFormat,
    required this.maxShopping,
    required this.maxShoppingCurrencyFormat,
    required this.isDiscountPercent,
    required this.discount,
    required this.discountText,
    required this.startDate,
    required this.endDate,
  });

  factory VoucherJaja.fromJson(Map<String, dynamic> json) => VoucherJaja(
        id: json["id"],
        isClaimed: json["isClaimed"],
        isSelected: json["isSelected"],
        isValid: json["isValid"],
        code: json["code"],
        name: json["name"],
        image: json["image"],
        type: json["type"],
        category: json["category"],
        quota: json["quota"],
        minShopping: json["minShopping"],
        minShoppingCurrencyFormat: json["minShoppingCurrencyFormat"],
        maxShopping: json["maxShopping"],
        maxShoppingCurrencyFormat: json["maxShoppingCurrencyFormat"],
        isDiscountPercent: json["isDiscountPercent"],
        discount: json["discount"],
        discountText: json["discountText"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isClaimed": isClaimed,
        "isSelected": isSelected,
        "isValid": isValid,
        "code": code,
        "name": name,
        "image": image,
        "type": type,
        "category": category,
        "quota": quota,
        "minShopping": minShopping,
        "minShoppingCurrencyFormat": minShoppingCurrencyFormat,
        "maxShopping": maxShopping,
        "maxShoppingCurrencyFormat": maxShoppingCurrencyFormat,
        "isDiscountPercent": isDiscountPercent,
        "discount": discount,
        "discountText": discountText,
        "startDate": startDate,
        "endDate": endDate,
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

class AddToCheckoutRequest {
  final String note1;
  final String note2;
  bool koin;

  AddToCheckoutRequest({
    required this.note1,
    required this.note2,
    required this.koin,
  });

  Map<String, dynamic> toJson() =>
      {"note1": note1, "note2": note2, "koin": koin};
}
