class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? address;


  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "address": address,
  };
}
