import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/boarding_model.dart';
import 'user/login_screen.dart';
import '../widgets/arrow_widget.dart';
import '../widgets/text_button_widget.dart';
import '../services/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String rn = '/on_boarding_screen';

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();
  var isLastBoardingPage = false;

  void navigationToLogin() {
    SharedPreferences.setData(onBoarding, true);
    Navigator.of(context).pushNamed(LogInScreen.rn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 7, right: 10),
            child: TextButtonWidget(
              function: navigationToLogin,
              text: 'skip',
              textColor: primaryColor,
              textSize: 16,
              letterSpace: 1.1,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int pageIndex) {
                  if (pageIndex == (BoardingModel.boardingList.length - 1)) {
                    setState(() {
                      isLastBoardingPage = true;
                    });
                  } else {
                    setState(() {
                      isLastBoardingPage = false;
                    });
                  }
                },
                controller: _pageController,
                itemCount: BoardingModel.boardingList.length,
                itemBuilder: (context, index) =>
                    buildBoardingItem(BoardingModel.boardingList[index]),
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: BoardingModel.boardingList.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: whiteColor, activeDotColor: primaryColor, dotHeight: 13),
                ),
                const Spacer(),
                ArrowWidget(
                  path: 'assets/images/arrow_right.svg',
                  navigation: () {
                    if (isLastBoardingPage) {
                      navigationToLogin();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.linearToEaseOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildBoardingItem(BoardingModel boardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage(boardingModel.image),
          )),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  boardingModel.title0,
                  style: const TextStyle(
                    fontFamily: 'Londrina',
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: Colors.black,
                  ),
                ),
                FittedBox(
                  child: Text(
                    boardingModel.title1,
                    style: const TextStyle(
                      fontFamily: 'Lemonada',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            boardingModel.body,
            style: const TextStyle(
              fontFamily: 'Lemonada',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      );
}
