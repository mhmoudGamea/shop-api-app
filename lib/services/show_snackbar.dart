// this dart file responsible for showing snackBar for the user in 2 cases [errors by red color, success by orange color]
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constants.dart';

enum ToastState {
  success,
  warning,
  error,
}

class ShowSnackBar {
  static showSnackBar(String message, ToastState state) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: changeColor(state),
        textColor: Colors.black,
        fontSize: 15.0
    );
  }

  static Color? changeColor(ToastState state) {
    if(state == ToastState.success) {
      return secondaryColor;
    } else if(state == ToastState.error) {
      return Colors.red.withOpacity(0.9);
    }
    return Colors.amber.withOpacity(0.9);
  }

}