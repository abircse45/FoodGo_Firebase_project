class CartModel {
  String? id;
  String? productname;
  String? productId;
  String? prouctImage;
  String? productDescription;
  String? productPrice;
  String? userId;
  int? qunatity;

  CartModel({
    this.id,
    this.productname,
    this.productId,
    this.prouctImage,
    this.productDescription,
    this.productPrice,
    this.userId,
    this.qunatity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    productname: json["productname"],
    productId: json["productId"],
    prouctImage: json["prouctImage"],
    productDescription: json["productDescription"],
    productPrice: json["productPrice"],
    userId: json["userId"],
    qunatity: json["qunatity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productname": productname,
    "productId": productId,
    "prouctImage": prouctImage,
    "productDescription": productDescription,
    "productPrice": productPrice,
    "userId": userId,
    "qunatity": qunatity,
  };
}
