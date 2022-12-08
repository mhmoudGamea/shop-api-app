import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/dio_helper.dart';

import '../models/search_model.dart';

class SearchProvider with ChangeNotifier {

  SearchModel? searchModel;

  SearchModel? get getSearchModel {
    return searchModel;
  }

  var isLoading = false;

  bool get getIsLoading {
    return isLoading;
  }

  void searchProduct(String text) async {
    isLoading = true;
    notifyListeners();
    final response = await DioHelper.postData(url: endpointSearch, data: {'text': text}, token: token, lang: 'en');
    searchModel = SearchModel.fromJson(response.data);
    isLoading = false;
    notifyListeners();
  }
}