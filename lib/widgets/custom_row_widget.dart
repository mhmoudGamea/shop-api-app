import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/providers/profile_provider.dart';

class CustomRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProfileProvider>(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            data.darkMode ? 'assets/images/sun.svg' : 'assets/images/moon.svg',
            color: primaryColor,
            width: 25,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          'Dark Mode',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        const Spacer(),
        Switch(
          value: data.getIsDark,
          onChanged: (value) {
            data.changeTheme();
          },
          activeColor: primaryColor,
          inactiveThumbColor: secondaryColor,
          inactiveTrackColor: secondaryColor.withOpacity(0.2),
        ),
      ],
    );
  }
}