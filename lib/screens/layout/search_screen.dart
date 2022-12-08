import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/providers/search_provider.dart';
import 'package:shop_app/services/show_snackbar.dart';
import 'package:shop_app/widgets/button_widget.dart';
import 'package:shop_app/widgets/text_form_field_widget.dart';

import '../../providers/home_provider.dart';
import '../../services/shared_preferences.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  String? text;

  @override
  Widget build(BuildContext context) {
    bool? darkMode = SharedPreferences.getData(isDark);
    final data = Provider.of<SearchProvider>(context).getSearchModel;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded, size: 30, color: primaryColor), onPressed: () {
          Navigator.of(context).pop();
        },),
        title: const Text(
          'Search',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
        child: Column(
          children: [
            Consumer<SearchProvider>(
              builder: (context, data, child) => Row(
                children: [
                  child!,
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: data.getIsLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : ButtonWidget(
                            radius: 15,
                            firstGradient: primaryColor,
                            secondGradient: whiteColor,
                            text: 'Done',
                            textSize: 15,
                            textColor: Colors.black,
                            function: () {
                              data.searchProduct(text!);
                            }),
                  )
                ],
              ),
              child: Flexible(
                flex: 3,
                child: TextFormFieldWidget(
                  hint: 'search',
                  onChange: (value) {
                    text = value;
                  },
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return ShowSnackBar.showSnackBar('please enter value', ToastState.error);
                    }
                    return null;
                  },
                  prefix: 'assets/images/search.svg',
                ),
              ),
            ),
            const SizedBox(height: 10),
            if(data != null)Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => Divider(color: Colors.grey[400],),
                itemCount: data.data.searchProducts.length,
                itemBuilder: (context, index) => buildSearchCustomWidget(context, data.data.searchProducts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchCustomWidget(BuildContext context, Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      decoration: BoxDecoration(
        color: secondaryDarkColor,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(product.image),
                    width: 110,
                    height: 110,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      overflow: TextOverflow.fade
                    ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${product.price.round()}',
                      style: const TextStyle(
                          fontSize: 11.5, fontWeight: FontWeight.w500, color: primaryColor),
                    ),
                    Consumer<HomeProvider>(
                      builder: (context, data, _) => IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () async {
                          Map<String, dynamic> message =
                          await data.changeFavourite(product.id, context);
                          ShowSnackBar.showSnackBar(message['message'], message['toast']);
                        },
                        icon: SvgPicture.asset(
                          'assets/images/heart.svg',
                          color: data.getFavourite[product.id]! ? Colors.red : Colors.grey,
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