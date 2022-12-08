import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/home_model.dart';

class CarouselCustomWidget extends StatelessWidget {
  final List<BannerModel> myBanners;
  const CarouselCustomWidget({Key? key, required this.myBanners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: myBanners
          .map(
            (e) => Image(
          image: NetworkImage(e.image),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ).toList(),
      options: CarouselOptions(
          initialPage: 0,
          viewportFraction: 1,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          scrollDirection: Axis.horizontal
      ),
    );
  }
}
