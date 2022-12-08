import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/user/login_screen.dart';
import 'package:shop_app/services/shared_preferences.dart';
import 'package:shop_app/widgets/button_widget.dart';

import '../../providers/profile_provider.dart';
import '../../widgets/custom_row_widget.dart';
import '../../widgets/email_phone_widget.dart';

class SettingScreen extends StatelessWidget {
  static const String rn = '/shop_screen';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? darkMode = SharedPreferences.getData(isDark);
    final profileData = Provider.of<ProfileProvider>(context).getProfileData;
    return Scaffold(
      backgroundColor: darkMode != null && darkMode == true ? primaryDarkColor : Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 2.5, color: whiteColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image(
                      image: NetworkImage(profileData!.userData!.image),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  profileData!.userData!.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 10),
            EmailPhoneWidget(
              image: 'assets/images/message.svg',
              text: profileData.userData!.email,
            ),
            const SizedBox(height: 10),
            EmailPhoneWidget(
              image: 'assets/images/mobile.svg',
              text: profileData.userData!.phone,
            ),
            const SizedBox(height: 10),
            CustomRowWidget(),
            const SizedBox(height: 10),
            Consumer<SharedPreferences>(builder: (context, data, _) {
              return data.getIsLoading
                  ? const CircularProgressIndicator(color: primaryColor)
                  : ButtonWidget(
                      radius: 10,
                      firstGradient: primaryColor,
                      secondGradient: whiteColor,
                      text: 'Log out',
                      textSize: 16,
                      textColor: Colors.black,
                      letterSpacing: 1,
                      function: () {
                        data.logOut().then(
                              (value) => Navigator.of(context).pushNamed(LogInScreen.rn),
                            );
                      });
            }),
          ],
        ),
      ),
    );
  }
}
