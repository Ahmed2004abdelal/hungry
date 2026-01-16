///add to cart

class CartModel {
  final int product_id;
  final int qty;
  final double spicy;
  final List<int> toppings;
  final List<int> options;

  CartModel({
    required this.product_id,
    required this.qty,
    required this.spicy,
    required this.toppings,
    required this.options,
  });

  Map<String, dynamic> toJson() => {
    "product_id": product_id,
    "quantity": qty,
    "spicy": spicy,
    "toppings": toppings,
    "side_options": options,
  };
}

class cartRequestModel {
  List<CartModel> items;
  cartRequestModel({required this.items});

  Map<String, dynamic> toJson() => {
    'items': items.map((e) => e.toJson()).toList(),
  };
}

///get cart

class GetCartResponse {
  final int code;
  final String mesg;
  final CartData cartdata;

  GetCartResponse({
    required this.mesg,
    required this.code,
    required this.cartdata,
  });

  factory GetCartResponse.fromjson(Map<String, dynamic> json) {
    return GetCartResponse(
      mesg: json['message'],
      code: json['code'],
      cartdata: CartData.fromjson(json['data']),
    );
  }
}

class CartData {
  final int id;
  final String totalPrice;
  final List<CartItems> cartItems;

  CartData({
    required this.id,
    required this.totalPrice,
    required this.cartItems,
  });

  factory CartData.fromjson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      totalPrice: json['total_price'],
      cartItems: (json['items'] as List)
          .map((e) => CartItems.fromjson(e))
          .toList(),
    );
  }
}

class CartItems {
  final int itemId;
  final int productId;
  final String name;
  final String img;
  final int qty;
  final String price;
  final String spicy;

  CartItems({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.img,
    required this.qty,
    required this.price,
    required this.spicy,
  });

  factory CartItems.fromjson(Map<String, dynamic> json) {
    return CartItems(
      itemId: json['item_id'],
      productId: json['product_id'],
      name: json['name'],
      img: json['image'],
      qty: json['quantity'],
      price: json['price'],
      spicy: json['spicy'],
    );
  }
}
