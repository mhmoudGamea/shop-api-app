import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/shared_preferences.dart';
import 'package:shop_app/services/show_snackbar.dart';

import '../models/home_model.dart';
import '../providers/home_provider.dart';

class GridCustomWidget extends StatelessWidget {
  final List<ProductModel> myProducts;

  const GridCustomWidget({Key? key, required this.myProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? darkMode = SharedPreferences.getData(isDark);
    return Container(
      color: darkMode != null && darkMode == true ?  primaryDarkColor : Colors.grey[300],
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2, childAspectRatio: 1 / 1.4),
        itemCount: myProducts.length,
        itemBuilder: (context, index) => buildProduct(context, myProducts[index], darkMode),
      ),
    );
  }

  Widget buildProduct(BuildContext context, ProductModel model, bool? darkMode) => Container(
        color: darkMode != null && darkMode == true ? secondaryDarkColor : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 180,
                ),
                if (model.discount != 0)
                  SvgPicture.asset('assets/images/offer.svg', fit: BoxFit.cover, width: 25),
              ],
            ),
            Text(model.name,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 2,
                overflow: TextOverflow.fade),
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  style: const TextStyle(
                      fontSize: 11.5, fontWeight: FontWeight.w500, color: primaryColor),
                ),
                const SizedBox(width: 10),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                Consumer<HomeProvider>(
                    builder: (context, data, _) => IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () async{
                          Map<String, dynamic> message = await data.changeFavourite(model.id, context);
                          ShowSnackBar.showSnackBar(message['message'], message['toast']);
                        },
                        icon: SvgPicture.asset(
                          'assets/images/heart.svg',
                          color: data.getFavourite[model.id]! ? Colors.red : Colors.grey,
                        )))
              ],
            ),
          ],
        ),
      );
}
