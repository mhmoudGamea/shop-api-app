import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/favourite_model.dart';
import '../services/dio_helper.dart';
import '../services/show_snackbar.dart';

class FavouriteProvider with ChangeNotifier {
  // handle getFavourite

  FavouriteModel? favouriteModel;

  FavouriteModel? get getFavouriteModel {
    return favouriteModel;
  }

  Future<FavouriteModel?> getFavouriteProducts() async {
    try {
      final response =  await DioHelper.getData(url: endpointFavourite, token: token, lang: 'en');
      favouriteModel = FavouriteModel.fromJson(response.data);
      notifyListeners();
    }catch(error) {
      debugPrint(error.toString());
      ShowSnackBar.showSnackBar('Please check internet connection.', ToastState.warning);
    }
    return favouriteModel;
  }
}