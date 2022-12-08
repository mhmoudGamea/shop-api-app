import 'package:flutter/material.dart';
import 'package:shop_app/screens/layout/setting_screen.dart';
import 'package:shop_app/screens/tabs_screen.dart';
import 'package:shop_app/services/shared_preferences.dart';
import 'package:shop_app/services/show_snackbar.dart';

import '../constants.dart';
import '../models/login_model.dart';
import '../services/dio_helper.dart';

class ProfileProvider with ChangeNotifier {
  // handle get profile data
  LoginModel? loginModel;

  LoginModel? get getProfileData {
    return loginModel;
  }

  void getProfile() async {
    try {
      final response = await DioHelper.getData(url: endpointProfile, token: token, lang: 'en');
      loginModel = LoginModel.fromJson(response.data);
      notifyListeners();
    } catch (error) {
      debugPrint('error in getProfile: ${error.toString()}');
    }
  }

  // handle post profile data
  var _isLoading = false;

  bool get getIsLoading {
    return _isLoading;
  }
  void updateProfile({required context, required name, required phone, required email}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.putData(
        url: endpointUpdateProfile,
        data: {'name': name, 'phone': phone, 'email': email},
        token: token!,
        lang: 'en',
      );
      loginModel = LoginModel.fromJson(response.data);
      _isLoading = false;
      notifyListeners();// to notify that the data has been changed and stop the loading
      if(loginModel!.status) {
        ShowSnackBar.showSnackBar(loginModel!.message!, ToastState.success);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TabsScreen()));
      }else {
        ShowSnackBar.showSnackBar(loginModel!.message!, ToastState.error);
      }
    } catch (error) {
      debugPrint('error in updateProfile: ${error.toString()}');
    }
  }

  // handle change switch button to dark or light

  var darkMode = false;

  bool get getIsDark {
    return darkMode;
  }

  void changeTheme() {
    darkMode = !darkMode;
    SharedPreferences.setData(isDark, darkMode);
    notifyListeners();
  }
}
