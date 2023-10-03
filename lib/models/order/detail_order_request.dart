class DetailOrderResponse {
  Status status;
  DetailOrder data;

  DetailOrderResponse({
    required this.status,
    required this.data,
  });

  factory DetailOrderResponse.fromJson(Map<String, dynamic> json) =>
      DetailOrderResponse(
        status: Status.fromJson(json["status"]),
        data: DetailOrder.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DetailOrder {
  String orderId;
  bool isGift;
  bool isTriggerFreeTotal;
  String createdAt;
  String status;
  String statusTitle;
  List<OrderHistory> orderHistory;
  dynamic trackingId;
  List<dynamic> tracking;
  String downloadOrderPdf;
  Address address;
  OrderPaymentRecent orderPaymentRecent;
  int totalAllProduct;
  List<dynamic> voucherJajaSelected;
  int subTotal;
  String subTotalCurrencyFormat;
  int shippingCost;
  String shippingCostCurrencyFormat;
  int voucherDiscountJaja;
  String voucherDiscountJajaCurrencyFormat;
  String voucherDiscountJajaDesc;
  int coin;
  int coinCurrencyFormat;
  String total;
  String totalCurrencyFormat;
  bool complain;
  dynamic complainDate;
  DateTime complainLimit;
  String solusiKomplain;
  bool isCancel;
  String cancelBy;
  String cancelReason;
  List<Item> items;

  DetailOrder({
    required this.orderId,
    required this.isGift,
    required this.isTriggerFreeTotal,
    required this.createdAt,
    required this.status,
    required this.statusTitle,
    required this.orderHistory,
    required this.trackingId,
    required this.tracking,
    required this.downloadOrderPdf,
    required this.address,
    required this.orderPaymentRecent,
    required this.totalAllProduct,
    required this.voucherJajaSelected,
    required this.subTotal,
    required this.subTotalCurrencyFormat,
    required this.shippingCost,
    required this.shippingCostCurrencyFormat,
    required this.voucherDiscountJaja,
    required this.voucherDiscountJajaCurrencyFormat,
    required this.voucherDiscountJajaDesc,
    required this.coin,
    required this.coinCurrencyFormat,
    required this.total,
    required this.totalCurrencyFormat,
    required this.complain,
    required this.complainDate,
    required this.complainLimit,
    required this.solusiKomplain,
    required this.isCancel,
    required this.cancelBy,
    required this.cancelReason,
    required this.items,
  });

  factory DetailOrder.fromJson(Map<String, dynamic> json) => DetailOrder(
        orderId: json["orderId"],
        isGift: json["isGift"],
        isTriggerFreeTotal: json["isTriggerFreeTotal"],
        createdAt: json["createdAt"],
        status: json["status"],
        statusTitle: json["statusTitle"],
        orderHistory: List<OrderHistory>.from(
            json["orderHistory"].map((x) => OrderHistory.fromJson(x))),
        trackingId: json["trackingId"],
        tracking: List<dynamic>.from((json["tracking"] ?? []).map((x) => x)),
        downloadOrderPdf: json["downloadOrderPdf"] ?? "",
        address: Address.fromJson(json["address"]),
        orderPaymentRecent:
            OrderPaymentRecent.fromJson(json["orderPaymentRecent"]),
        totalAllProduct: json["totalAllProduct"],
        voucherJajaSelected:
            List<dynamic>.from(json["voucherJajaSelected"].map((x) => x)),
        subTotal: json["subTotal"],
        subTotalCurrencyFormat: json["subTotalCurrencyFormat"],
        shippingCost: json["shippingCost"],
        shippingCostCurrencyFormat: json["shippingCostCurrencyFormat"],
        voucherDiscountJaja: json["voucherDiscountJaja"],
        voucherDiscountJajaCurrencyFormat:
            json["voucherDiscountJajaCurrencyFormat"],
        voucherDiscountJajaDesc: json["voucherDiscountJajaDesc"],
        coin: json["coin"],
        coinCurrencyFormat: json["coinCurrencyFormat"],
        total: json["total"],
        totalCurrencyFormat: json["totalCurrencyFormat"],
        complain: json["complain"],
        complainDate: json["complain_date"] ?? "",
        complainLimit: DateTime.parse(json["complain_limit"]),
        solusiKomplain: json["solusi_komplain"],
        isCancel: json["isCancel"],
        cancelBy: json["cancelBy"] ?? "",
        cancelReason: json["cancelReason"] ?? "",
        items:
            List<Item>.from((json["items"] ?? []).map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "isGift": isGift,
        "isTriggerFreeTotal": isTriggerFreeTotal,
        "createdAt": createdAt,
        "status": status,
        "statusTitle": statusTitle,
        "orderHistory": List<dynamic>.from(orderHistory.map((x) => x.toJson())),
        "trackingId": trackingId,
        "tracking": List<dynamic>.from(tracking.map((x) => x)),
        "downloadOrderPdf": downloadOrderPdf,
        "address": address.toJson(),
        "orderPaymentRecent": orderPaymentRecent.toJson(),
        "totalAllProduct": totalAllProduct,
        "voucherJajaSelected":
            List<dynamic>.from(voucherJajaSelected.map((x) => x)),
        "subTotal": subTotal,
        "subTotalCurrencyFormat": subTotalCurrencyFormat,
        "shippingCost": shippingCost,
        "shippingCostCurrencyFormat": shippingCostCurrencyFormat,
        "voucherDiscountJaja": voucherDiscountJaja,
        "voucherDiscountJajaCurrencyFormat": voucherDiscountJajaCurrencyFormat,
        "voucherDiscountJajaDesc": voucherDiscountJajaDesc,
        "coin": coin,
        "coinCurrencyFormat": coinCurrencyFormat,
        "total": total,
        "totalCurrencyFormat": totalCurrencyFormat,
        "complain": complain,
        "complain_date": complainDate,
        "complain_limit": complainLimit.toIso8601String(),
        "solusi_komplain": solusiKomplain,
        "isCancel": isCancel,
        "cancelBy": cancelBy,
        "cancelReason": cancelReason,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Address {
  String receiverName;
  String phoneNumber;
  String address;
  String latitude;
  String longitude;
  String postalCode;

  Address({
    required this.receiverName,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        receiverName: json["receiverName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        postalCode: json["postalCode"],
      );

  Map<String, dynamic> toJson() => {
        "receiverName": receiverName,
        "phoneNumber": phoneNumber,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "postalCode": postalCode,
      };
}

class Item {
  String id;
  String invoice;
  Address address;
  bool isRating;
  dynamic note;
  String downloadInvoicePdf;
  int voucherDiscount;
  String voucherDiscountCurrencyFormat;
  int total;
  String totalCurrencyFormat;
  int totalDiscount;
  String totalDiscountCurrencyFormat;
  int totalWeight;
  Store store;
  ShippingSelected shippingSelected;
  VoucherStoreSelected voucherStoreSelected;
  List<Product> products;

  Item({
    required this.id,
    required this.invoice,
    required this.address,
    required this.isRating,
    required this.note,
    required this.downloadInvoicePdf,
    required this.voucherDiscount,
    required this.voucherDiscountCurrencyFormat,
    required this.total,
    required this.totalCurrencyFormat,
    required this.totalDiscount,
    required this.totalDiscountCurrencyFormat,
    required this.totalWeight,
    required this.store,
    required this.shippingSelected,
    required this.voucherStoreSelected,
    required this.products,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        invoice: json["invoice"],
        address: Address.fromJson(json["address"]),
        isRating: json["isRating"],
        note: json["note"] ?? "",
        downloadInvoicePdf: json["downloadInvoicePdf"] ?? "",
        voucherDiscount: json["voucherDiscount"],
        voucherDiscountCurrencyFormat: json["voucherDiscountCurrencyFormat"],
        total: json["total"],
        totalCurrencyFormat: json["totalCurrencyFormat"],
        totalDiscount: json["totalDiscount"],
        totalDiscountCurrencyFormat: json["totalDiscountCurrencyFormat"],
        totalWeight: json["totalWeight"],
        store: Store.fromJson(json["store"]),
        shippingSelected: ShippingSelected.fromJson(json["shippingSelected"]),
        voucherStoreSelected:
            VoucherStoreSelected.fromJson(json["voucherStoreSelected"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "address": address.toJson(),
        "isRating": isRating,
        "note": note,
        "downloadInvoicePdf": downloadInvoicePdf,
        "voucherDiscount": voucherDiscount,
        "voucherDiscountCurrencyFormat": voucherDiscountCurrencyFormat,
        "total": total,
        "totalCurrencyFormat": totalCurrencyFormat,
        "totalDiscount": totalDiscount,
        "totalDiscountCurrencyFormat": totalDiscountCurrencyFormat,
        "totalWeight": totalWeight,
        "store": store.toJson(),
        "shippingSelected": shippingSelected.toJson(),
        "voucherStoreSelected": voucherStoreSelected.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String productId;
  String name;
  dynamic greetingCardGift;
  String slug;
  String image;
  String description;
  List<dynamic> badges;
  String variantId;
  dynamic variant;
  String qty;
  int weight;
  bool isDiscount;
  String price;
  String priceCurrencyFormat;
  dynamic priceDiscount;
  dynamic priceDiscountCurrencyFormat;
  bool isUseVoucher;
  int rate;
  List<dynamic> images;
  dynamic video;
  int subTotal;
  String subTotalCurrencyFormat;

  Product({
    required this.productId,
    required this.name,
    required this.greetingCardGift,
    required this.slug,
    required this.image,
    required this.description,
    required this.badges,
    required this.variantId,
    required this.variant,
    required this.qty,
    required this.weight,
    required this.isDiscount,
    required this.price,
    required this.priceCurrencyFormat,
    required this.priceDiscount,
    required this.priceDiscountCurrencyFormat,
    required this.isUseVoucher,
    required this.rate,
    required this.images,
    required this.video,
    required this.subTotal,
    required this.subTotalCurrencyFormat,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        name: json["name"],
        greetingCardGift: json["greetingCardGift"] ?? "",
        slug: json["slug"],
        image: json["image"],
        description: json["description"],
        badges: List<dynamic>.from(json["badges"].map((x) => x)),
        variantId: json["variantId"],
        variant: json["variant"] ?? "",
        qty: json["qty"],
        weight: json["weight"],
        isDiscount: json["isDiscount"],
        price: json["price"],
        priceCurrencyFormat: json["priceCurrencyFormat"],
        priceDiscount: json["priceDiscount"] ?? "",
        priceDiscountCurrencyFormat: json["priceDiscountCurrencyFormat"] ?? "",
        isUseVoucher: json["isUseVoucher"],
        rate: json["rate"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        video: json["video"] ?? "",
        subTotal: json["subTotal"],
        subTotalCurrencyFormat: json["subTotalCurrencyFormat"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "greetingCardGift": greetingCardGift,
        "slug": slug,
        "image": image,
        "description": description,
        "badges": List<dynamic>.from(badges.map((x) => x)),
        "variantId": variantId,
        "variant": variant,
        "qty": qty,
        "weight": weight,
        "isDiscount": isDiscount,
        "price": price,
        "priceCurrencyFormat": priceCurrencyFormat,
        "priceDiscount": priceDiscount,
        "priceDiscountCurrencyFormat": priceDiscountCurrencyFormat,
        "isUseVoucher": isUseVoucher,
        "rate": rate,
        "images": List<dynamic>.from(images.map((x) => x)),
        "video": video,
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
  dynamic etd;
  String etdText;
  String sendTime;
  dynamic dateSendTime;

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
    required this.dateSendTime,
  });

  factory ShippingSelected.fromJson(Map<String, dynamic> json) =>
      ShippingSelected(
        code: json["code"],
        type: json["type"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        priceCurrencyFormat: json["priceCurrencyFormat"],
        etd: json["etd"] ?? "",
        etdText: json["etdText"],
        sendTime: json["sendTime"],
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
        "dateSendTime": dateSendTime,
      };
}

class Store {
  String id;
  String uid;
  String name;
  dynamic phone;
  String slug;
  String image;
  String location;
  FullLocation fullLocation;

  Store({
    required this.id,
    required this.uid,
    required this.name,
    required this.phone,
    required this.slug,
    required this.image,
    required this.location,
    required this.fullLocation,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"] ?? "",
        slug: json["slug"],
        image: json["image"],
        location: json["location"],
        fullLocation: FullLocation.fromJson(json["fullLocation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "name": name,
        "phone": phone,
        "slug": slug,
        "image": image,
        "location": location,
        "fullLocation": fullLocation.toJson(),
      };
}

class FullLocation {
  String address;
  dynamic addressGoogle;
  dynamic latitude;
  dynamic longitude;
  String province;
  String city;
  String cityId;
  String district;
  String subdistrict;
  String postalCode;

  FullLocation({
    required this.address,
    required this.addressGoogle,
    required this.latitude,
    required this.longitude,
    required this.province,
    required this.city,
    required this.cityId,
    required this.district,
    required this.subdistrict,
    required this.postalCode,
  });

  factory FullLocation.fromJson(Map<String, dynamic> json) => FullLocation(
        address: json["address"],
        addressGoogle: json["addressGoogle"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        province: json["province"],
        city: json["city"],
        cityId: json["cityId"],
        district: json["district"],
        subdistrict: json["subdistrict"],
        postalCode: json["postalCode"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "addressGoogle": addressGoogle,
        "latitude": latitude,
        "longitude": longitude,
        "province": province,
        "city": city,
        "cityId": cityId,
        "district": district,
        "subdistrict": subdistrict,
        "postalCode": postalCode,
      };
}

class VoucherStoreSelected {
  VoucherStoreSelected();

  factory VoucherStoreSelected.fromJson(Map<String, dynamic> json) =>
      VoucherStoreSelected();

  Map<String, dynamic> toJson() => {};
}

class OrderHistory {
  String name;
  bool isActive;

  OrderHistory({
    required this.name,
    required this.isActive,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        name: json["name"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isActive": isActive,
      };
}

class OrderPaymentRecent {
  String idToken;
  String orderId;
  dynamic billingId;
  String token;
  String grandTotal;
  String fee;
  dynamic tokenApp;
  String paymentId;
  String paymentType;
  String paymentTypeLabel;
  String paymentSub;
  String paymentSubLabel;
  String paymentVaOrCodeOrLink;
  String paymentForm;
  DateTime createdDate;

  OrderPaymentRecent({
    required this.idToken,
    required this.orderId,
    required this.billingId,
    required this.token,
    required this.grandTotal,
    required this.fee,
    required this.tokenApp,
    required this.paymentId,
    required this.paymentType,
    required this.paymentTypeLabel,
    required this.paymentSub,
    required this.paymentSubLabel,
    required this.paymentVaOrCodeOrLink,
    required this.paymentForm,
    required this.createdDate,
  });

  factory OrderPaymentRecent.fromJson(Map<String, dynamic> json) =>
      OrderPaymentRecent(
        idToken: json["id_token"],
        orderId: json["order_id"],
        billingId: json["billing_id"] ?? "",
        token: json["token"] ?? "",
        grandTotal: json["grand_total"],
        fee: json["fee"],
        tokenApp: json["token_app"] ?? "",
        paymentId: json["payment_id"],
        paymentType: json["payment_type"],
        paymentTypeLabel: json["payment_type_label"],
        paymentSub: json["payment_sub"],
        paymentSubLabel: json["payment_sub_label"],
        paymentVaOrCodeOrLink: json["payment_va_or_code_or_link"],
        paymentForm: json["payment_form"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
        "order_id": orderId,
        "billing_id": billingId,
        "token": token,
        "grand_total": grandTotal,
        "fee": fee,
        "token_app": tokenApp,
        "payment_id": paymentId,
        "payment_type": paymentType,
        "payment_type_label": paymentTypeLabel,
        "payment_sub": paymentSub,
        "payment_sub_label": paymentSubLabel,
        "payment_va_or_code_or_link": paymentVaOrCodeOrLink,
        "payment_form": paymentForm,
        "created_date": createdDate.toIso8601String(),
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
