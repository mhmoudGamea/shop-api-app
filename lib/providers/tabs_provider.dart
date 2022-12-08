import 'package:flutter/material.dart';

import '../screens/layout/favourite_screen.dart';
import '../screens/layout/setting_screen.dart';
import '../screens/layout/home_screen.dart';
import '../screens/layout/category_screen.dart';

class TabsProvider with ChangeNotifier {
  var _initialIndex = 0;

  int get getIndex {
    return _initialIndex;
  }

  void changeInitialIndex(int value) {
    _initialIndex = value;
    notifyListeners();
  }

  final List<Map<String, dynamic>> _screens = [
    {'title': 'Salla', 'screen': HomeScreen()},
    {'title': 'Category', 'screen': const CategoryScreen()},
    {'title': 'Favourite', 'screen': const FavouriteScreen()},
    {'title': 'Setting', 'screen': const SettingScreen()},
  ];

  Map<String, dynamic> getScreen(int value) {
    return _screens.elementAt(value);
  }

}