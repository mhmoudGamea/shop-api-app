import 'package:flutter/material.dart';

class ChangeFavouriteModel {

  final bool status;
  final String message;

  ChangeFavouriteModel({required this.status, required this.message});

  factory ChangeFavouriteModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavouriteModel(status: json['status'], message: json['message']);
  }

}
