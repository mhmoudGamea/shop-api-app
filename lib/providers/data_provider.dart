import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/tabs_screen.dart';

import '../../services/dio_helper.dart';
import '../models/login_model.dart';
import '../services/show_snackbar.dart';
import '../screens/layout/home_screen.dart';
import '../services/shared_preferences.dart';

class DataProvider with ChangeNotifier {
  var _isLoading = false;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get getLoading {
    return _isLoading;
  }

  void userLogin({required context, required email, required password}) async {
    try {
      toggleLoading(); // isLoading = true
      final response = await DioHelper.postData(url: endpointLogin, data: {'email': email, 'password': password}, lang: 'en');
      toggleLoading(); // isLoading = false
      LoginModel? loginModel = LoginModel.fromJson(response.data);
      if(loginModel.status) { // successfully registration
        ShowSnackBar.showSnackBar(loginModel.message!, ToastState.success);
        _isLoading = false;
        notifyListeners();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TabsScreen()));
        token = loginModel.userData!.token;
        SharedPreferences.setData(onToken, token);
      }else {// un successful registration
        ShowSnackBar.showSnackBar(response.data['message']!, ToastState.error);
      }
    }catch(error) {
      ShowSnackBar.showSnackBar('Please check internet connection', ToastState.warning);
    }
    notifyListeners();
  }

  void userRegister({required context, required name, required email, required phone, required password}) async{
    final response = await DioHelper.postData(url: endpointRegister, data: {'name': name, 'email': email, 'phone': phone, 'password': password}, lang: 'en');
    LoginModel loginModel = LoginModel.fromJson(response.data);
    if(loginModel.status) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TabsScreen()));
      ShowSnackBar.showSnackBar(loginModel.message!, ToastState.success);
      token = loginModel.userData!.token;
      SharedPreferences.setData(onToken, token);
    } else {
      ShowSnackBar.showSnackBar(loginModel.message!, ToastState.error);
    }
  }
}
//01054823698712