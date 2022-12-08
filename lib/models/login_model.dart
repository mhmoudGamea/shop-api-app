class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String token;

  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.image,
      required this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      token: json['token'],
    );
  }
}

class LoginModel {
  final bool status;
  String? message;
  UserData? userData;

  LoginModel({required this.status, required this.message, this.userData});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      userData: json['data'] == null ? null : UserData.fromJson(json['data']),
    );
  }
}
