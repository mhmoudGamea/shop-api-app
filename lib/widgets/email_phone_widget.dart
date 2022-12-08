import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class EmailPhoneWidget extends StatelessWidget {
  final String image;
  final String text;
  const EmailPhoneWidget({Key? key, required this.image, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(image,
            color: primaryColor,
            width: 25,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        )
      ],
    );
  }
}
