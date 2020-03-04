import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int id;
  final String email;
  final String phoneNumber;
  final String fullName;
  final String password;
  final String token;

  User({
    this.id,
    this.email,
    this.phoneNumber,
    this.fullName,
    this.password,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      new User(
        id: json["id"] == null ? null : json["id"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        fullName: json["full_name"],
        password: json["password"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ? null : id,
        "email": email,
        "phone_number": phoneNumber,
        "full_name": fullName,
        "password": password,
        "token": token,
      };
}
