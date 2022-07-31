class ProfileModel {
  String Email;
  String UserName;
  String PhoneNumber;

  ProfileModel({
    required this.Email,
    required this.UserName,
    required this.PhoneNumber

  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfileModel(
        Email: json["Email"],
        UserName: json["UserName"],
        PhoneNumber: json["PhoneNumber"],

      );
}





