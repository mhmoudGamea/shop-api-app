import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

import '../services/show_snackbar.dart';
import '../models/category_model.dart';
import '../services/dio_helper.dart';

class CategoryProvider with ChangeNotifier {
  CategoryModel? categoryModel;

  CategoryModel? get getCategoryModel {
    return categoryModel;
  }

  void getCategory() async {
    try {
      final response = await DioHelper.getData(url: endpointCategory, token: token, lang: 'en');
      categoryModel = CategoryModel.fromJson(response.data);
      notifyListeners();
    }catch (error) {
      debugPrint(error.toString());
      ShowSnackBar.showSnackBar('Please check Internet Connection', ToastState.warning);
    }
  }
}