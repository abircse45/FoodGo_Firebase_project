// To parse this JSON data, do


class OrderModel {
  String? orderId;
  String? userId;
  double? totalAmount;
  final List<Map<String,dynamic>> ? items;
  int? totalItems;

  OrderModel( {
    this.userId,
    this.orderId,
    this.totalAmount,
    this.items,
    this.totalItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    userId: json["userId"],
    orderId: json["orderId"],
    totalAmount: json["totalAmount"],
    items: List<Map<String,dynamic>>.from(json["items"]?? []),
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "totalAmount": totalAmount,
    "totalItems": totalItems,
    "items" : items,
    "orderId" : orderId,
  };
}
