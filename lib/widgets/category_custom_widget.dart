import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/shared_preferences.dart';

import '../models/category_model.dart';

class CategoryCustomWidget extends StatelessWidget {

  final CategoryDataModel category;
  const CategoryCustomWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? darkMode = SharedPreferences.getData(isDark);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
          border: Border.all(color: darkMode != null && darkMode == true ?  primaryDarkColor : Colors.grey[300]!, width: 2 )
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(category.image),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          Container(
            width: 100,
            height: 30,
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.7),
            child: Text(
              category.name,
              maxLines: 1,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500,
                  color: Colors.white, overflow: TextOverflow.fade),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
