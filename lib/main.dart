import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/on_boarding_screen.dart';
import './screens/user/login_screen.dart';
import './screens/user/signup_screen.dart';
import './constants.dart';
import '../services/shared_preferences.dart';
import './services/dio_helper.dart';
import './providers/tabs_provider.dart';
import './screens/tabs_screen.dart';
import './providers/home_provider.dart';
import './providers/category_provider.dart';
import './providers/favourite_provider.dart';
import './providers/profile_provider.dart';
import './providers/search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initializeDio();
  await SharedPreferences.init();
  token = SharedPreferences.getData(onToken);
  runApp(ShopApp(token));
}

class ShopApp extends StatelessWidget {
  String? myToken;
  ShopApp(this.myToken);

  @override
  Widget build(BuildContext context) {
    print(token);
    bool? boarding = SharedPreferences.getData(onBoarding);
    bool? darkMode = SharedPreferences.getData(isDark);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabsProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => FavouriteProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => SharedPreferences()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: Consumer<ProfileProvider>(
        builder: (context, data, _) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: data.getIsDark ? (darkMode == true ? ThemeMode.dark : ThemeMode.light) : ThemeMode.light,
          home: boarding != null && boarding ? (myToken == null ? LogInScreen() : const TabsScreen()) : const OnBoardingScreen(),
          routes: {
            LogInScreen.rn : (context) => LogInScreen(),
            SignUpScreen.rn : (context) => SignUpScreen(),
          },
        ),
      ),
    );
  }
}
