import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart' as sh;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/services/dio_helper.dart';
import 'package:shop_app/services/show_snackbar.dart';

class SharedPreferences with ChangeNotifier {
  static late sh.SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await sh.SharedPreferences.getInstance();
  }

  // DARK & LIGHT MODE
  static Future<bool> setDarkBoolean(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  static bool? getDarkBoolean(String key) {
    return _sharedPreferences.getBool(key);
  }

  // SAVE ANY KIND OF DATA
  static Future<bool> setData(String key, dynamic value) async {
    if(value is String) return await _sharedPreferences.setString(key, value);
    if(value is int) return await _sharedPreferences.setInt(key, value);
    if(value is double) return await _sharedPreferences.setDouble(key, value);
    return await _sharedPreferences.setBool(key, value);
  }

  // GET ANY KIND OF DATA
  static dynamic getData(String key) {
    return _sharedPreferences.get(key);
  }

  // LOGOUT THE USER

  var isLoading = false;

  bool get getIsLoading {
    return isLoading;
  }

  late LogoutModel logoutModel;
  Future<void> logOut() async{
    isLoading = !isLoading;
    notifyListeners();
    await _sharedPreferences.remove(onToken);
    final response = await DioHelper.postData(url: endpointLogout, data: {}, token: token, lang: 'en');
    logoutModel = LogoutModel.fromJson(response.data);
    if(logoutModel.status) {
      ShowSnackBar.showSnackBar(logoutModel.message, ToastState.success);
    }else {
      ShowSnackBar.showSnackBar(logoutModel.message, ToastState.error);
    }
    isLoading = !isLoading;
    notifyListeners();
  }
}