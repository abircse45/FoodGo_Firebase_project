// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);



class BannerModel {
  String? id;
  String? imageUrl;

  BannerModel({
    this.id,
    this.imageUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageUrl": imageUrl,
  };
}
