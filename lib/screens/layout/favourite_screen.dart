import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/favourite_model.dart';

import '../../constants.dart';
import '../../providers/favourite_provider.dart';
import '../../providers/home_provider.dart';
import '../../services/shared_preferences.dart';
import '../../services/show_snackbar.dart';

class FavouriteScreen extends StatelessWidget {
  static const String rn = '/shop_screen';

  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? darkMode = SharedPreferences.getData(isDark);
    return Scaffold(
      backgroundColor: darkMode != null && darkMode == true ? primaryDarkColor : Colors.grey[200],
      body: FutureBuilder<FavouriteModel?>(
        future: Provider.of<FavouriteProvider>(context, listen: false).getFavouriteProducts(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(color: primaryColor,)
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.data.favData.length,
                  itemBuilder: (context, index) =>
                      favouriteCustomWidget(context, snapshot.data?.data.favData[index], darkMode),
                );
        },
      ),
    );
  }

  Widget favouriteCustomWidget(BuildContext context, FavouriteData? favData, bool? darkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: darkMode != null && darkMode == true ?  secondaryDarkColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 110,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(favData!.product.image),
                  width: 110,
                  height: 110,
                ),
                if (favData.product.discount != 0)
                  SvgPicture.asset('assets/images/offer.svg', fit: BoxFit.cover, width: 25),
              ],
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              children: [
                Text(favData.product.name,
                    style:
                    Theme.of(context).textTheme.bodyText1,
                    //style:const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500, height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.fade),
                Row(
                  children: [
                    Text(
                      '${favData.product.price.round()}',
                      style: const TextStyle(
                          fontSize: 11.5, fontWeight: FontWeight.w500, color: primaryColor),
                    ),
                    const SizedBox(width: 10),
                    if (favData.product.discount != 0)
                      Text(
                        '${favData.product.oldPrice.round()}',
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
                        onPressed: () async {
                          Map<String, dynamic> message =
                              await data.changeFavourite(favData.product.id, context);
                          ShowSnackBar.showSnackBar(message['message'], message['toast']);
                        },
                        icon: SvgPicture.asset(
                          'assets/images/heart.svg',
                          color: data.getFavourite[favData.product.id]! ? Colors.red : Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}