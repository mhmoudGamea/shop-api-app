import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/services/shared_preferences.dart';

import '../../constants.dart';
import '../../models/category_model.dart';
import '../../providers/category_provider.dart';

class CategoryScreen extends StatelessWidget {
  static const String rn = '/shop_screen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? darkMode = SharedPreferences.getData(isDark);
    final categoryData = Provider.of<CategoryProvider>(context).getCategoryModel;
    return Scaffold(
      backgroundColor: darkMode != null && darkMode == true ? primaryDarkColor : Colors.grey[200],
      body: categoryData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: categoryData.cData.data.length,
              itemBuilder: (context, index) => categoryCustomWidget(context, categoryData.cData.data[index], darkMode),
            ),
    );
  }

  Widget categoryCustomWidget(BuildContext context, CategoryDataModel categoryDataModel, bool? darkMode) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: darkMode != null && darkMode == true ? secondaryDarkColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                  image: NetworkImage(categoryDataModel.image),
                  fit: BoxFit.cover,
                  width: 120,
                  height: 110),
            ),
          ),
          const SizedBox(width: 15),
          Text(
            categoryDataModel.name,
            style:
                Theme.of(context).textTheme.bodyText1,
          ),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/images/arrowRight.svg',
              color: primaryColor,
              width: 28,
              height: 28,
            ),
          )
        ],
      ),
    );
  }
}
