class LogoutModel {
  final bool status;
  final String message;

  LogoutModel({required this.status, required this.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(status: json['status'], message: json['message']);
  }
}