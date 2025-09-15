class CartModel {
  String? id;
  String? productname;
  String? productId;
  String? prouctImage;
  String? productDescription;
  String? productPrice;
  String? userId;
  int? quantity;

  CartModel({
    this.id,
    this.productname,
    this.productId,
    this.prouctImage,
    this.productDescription,
    this.productPrice,
    this.userId,
    this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    productname: json["productname"],
    productId: json["productId"],
    prouctImage: json["prouctImage"],
    productDescription: json["productDescription"],
    productPrice: json["productPrice"],
    userId: json["userId"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productname": productname,
    "productId": productId,
    "prouctImage": prouctImage,
    "productDescription": productDescription,
    "productPrice": productPrice,
    "userId": userId,
    "quantity": quantity,
  };
}
