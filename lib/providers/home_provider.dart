// in this class i handle the home data & favourite data they all in one class HomeProvider
// so don't be confused, maybe i should split them later on
import 'package:flutter/material.dart';

import '../providers/favourite_provider.dart';
import '../services/dio_helper.dart';
import '../constants.dart';
import '../services/show_snackbar.dart';
import '../models/home_model.dart';
import '../models/change_favourite_model.dart';

class HomeProvider with ChangeNotifier {

  // handle Home part
  HomeModel? homeModel;

  HomeModel? get getHomeModel {
    return homeModel;
  }

  void getHome() async {
    //print(token);
    try {
      final response =  await DioHelper.getData(url: endpointHome, token: token, lang: 'en');
      homeModel = HomeModel.fromJson(response.data);
      for (var element in homeModel!.data.product) {
        isFavourite.addAll(
            {element.id: element.inFavourite}
        );
      }
      print(isFavourite);
      notifyListeners();
    }catch(error) {
      debugPrint(error.toString());
      ShowSnackBar.showSnackBar('Please check internet connection.', ToastState.warning);
    }
  }

  // handle Change Favourite part
  Map<int, bool> isFavourite = {};

  Map<int, bool> get getFavourite {
    return isFavourite;
  }

  ChangeFavouriteModel? changeFavouriteModel;


  Future<Map<String, dynamic>> changeFavourite(int productId, BuildContext context) async {
    isFavourite[productId] = !isFavourite[productId]!;
    notifyListeners();
    try{
      final response = await DioHelper.postData(url: endpointFavourite, data: {'product_id': productId}, token: token, lang: 'en');
      changeFavouriteModel = ChangeFavouriteModel.fromJson(response.data);
      if(!changeFavouriteModel!.status) {
        isFavourite[productId] = !isFavourite[productId]!;
        return {'message' : 'An error happen', 'toast': ToastState.error};
      } else {
        FavouriteProvider f = FavouriteProvider();
        f.getFavouriteProducts();
        return {'message' : changeFavouriteModel!.message, 'toast': ToastState.success};
      }
      notifyListeners();
    }catch (error) {
      if(!changeFavouriteModel!.status) {
        isFavourite[productId] = !isFavourite[productId]!;
      }
      debugPrint(error.toString());
      return {'message' : 'Please check internet connection.1', 'toast': ToastState.warning};
    }
  }

}