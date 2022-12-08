import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/layout/search_screen.dart';
import 'package:shop_app/screens/user/update_profile_screen.dart';

import '../providers/profile_provider.dart';
import '../providers/category_provider.dart';
import '../providers/favourite_provider.dart';
import '../providers/home_provider.dart';
import '../constants.dart';
import '../providers/tabs_provider.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).getHome();
    Provider.of<CategoryProvider>(context, listen: false).getCategory();
    Provider.of<FavouriteProvider>(context, listen: false).getFavouriteProducts();
    Provider.of<ProfileProvider>(context, listen: false).getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TabsProvider>(context);
    final Map<String, dynamic> myScreen = data.getScreen(data.getIndex);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          myScreen['title'],
          style: const TextStyle(color: primaryColor),
        ),
        actions: [
          myScreen['title'] == 'Setting' ? IconButton(icon: SvgPicture.asset('assets/images/userEdit.svg' , color: primaryColor, width: 28), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
          },) : IconButton(icon: SvgPicture.asset('assets/images/search.svg' , color: primaryColor, width: 28), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen()));
          },)
        ],
      ),
      body: myScreen['screen'],
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: whiteColor, width: 1.1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: data.getIndex,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          onTap: (value) {
            data.changeInitialIndex(value);
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/home.svg',
                  color: data.getIndex == 0 ? primaryColor : whiteColor,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/category.svg',
                  color: data.getIndex == 1 ? primaryColor : whiteColor,
                ),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/heart.svg',
                  color: data.getIndex == 2 ? primaryColor : whiteColor,
                ),
                label: 'Favourite'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/setting.svg',
                  color: data.getIndex == 3 ? primaryColor : whiteColor,
                ),
                label: 'Setting'),
          ],
        ),
      ),
    );
  }
}
