import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/services/shared_preferences.dart';

import '../../constants.dart';
import '../../providers/category_provider.dart';
import '../../providers/home_provider.dart';
import '../../widgets/carousel_custom_widget.dart';
import '../../widgets/grid_custom_widget.dart';
import '../../widgets/category_custom_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String rn = '/shop_screen';

  @override
  Widget build(BuildContext context) {
    bool? darkMode = SharedPreferences.getData(isDark);
    final homeData = Provider.of<HomeProvider>(context).getHomeModel;
    final categoryData = Provider.of<CategoryProvider>(context).getCategoryModel;
    return Scaffold(
      backgroundColor: darkMode != null && darkMode == true ? secondaryDarkColor : Colors.grey[200],
      body: homeData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselCustomWidget(myBanners: homeData.data.banner),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: categoryData!.cData.data.length,
                            itemBuilder: (context, index) => CategoryCustomWidget(category: categoryData.cData.data[index]),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'New Products',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridCustomWidget(myProducts: homeData.data.product),
                ],
              ),
            ),
    );
  }
}