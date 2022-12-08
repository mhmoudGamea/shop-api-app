import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';

class ArrowWidget extends StatelessWidget {
  final String path;
  final VoidCallback navigation;
  const ArrowWidget({Key? key, required this.path, required this.navigation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigation,
      child: Container(
        height: 47,
        width: 47,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
        ),
        child: SvgPicture.asset('assets/images/arrow_right.svg', color: Colors.white, width: 26,),
      ),
    );
  }
}
