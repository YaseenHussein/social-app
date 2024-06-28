import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/componts.dart/componnts.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/colors.dart';
import '../login/login.dart';

class OnBoardingModel {
  String img;
  String title;
  String titleBody;
  OnBoardingModel({
    required this.img,
    required this.title,
    required this.titleBody,
  });
}

class OnBorading extends StatefulWidget {
  const OnBorading({Key? key}) : super(key: key);

  @override
  State<OnBorading> createState() => _OnBoradingState();
}

class _OnBoradingState extends State<OnBorading> {
  List<OnBoardingModel> listOnBoarding = [
    OnBoardingModel(
      img: "assets/images/image0.png",
      title: "Communication with any One",
      titleBody: "Communication with your friend and family",
    ),
    OnBoardingModel(
      img: "assets/images/image1.png",
      title: "a big Firebase Cloud",
      titleBody: "You can Post many posts",
    ),
    OnBoardingModel(
      img: "assets/images/image2.png",
      title: "enjoy with us ",
      titleBody: "Likes and comments to Many Poppler people",
    ),
  ];
  final PageController pageController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                onSubmit(context);
              },
              child: const Text(
                "skip",
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  if (value == listOnBoarding.length - 1) {
                    setState(() {
                      isLast = true;

                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: listOnBoarding.length,
                itemBuilder: (context, index) =>
                    onBoradingBuild(listOnBoarding[index]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  effect: const ExpandingDotsEffect(
                    //شكل الاندكبتور ايش من نوع
                    dotColor: Colors.grey,
                    activeDotColor: defaultColorThem, //عندما يكون واقف عليه
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                  count: listOnBoarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      onSubmit(context);
                    } else {
                      ///////////// الانتقال من صفحة الى صفحة//////////////
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,);
                      //////////////////////////////
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget onBoradingBuild(OnBoardingModel list) => Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(list.img),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          list.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            fontFamily: 'font1',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          list.titleBody,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            fontFamily: 'LBC Regular',
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
Widget buildPageView(OnBoardingModel list) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(list.img),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          list.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            fontFamily: 'font1',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          list.titleBody,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            fontFamily: 'LBC Regular',
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
void onSubmit(context) {
  CacheHelper.putData(key: "onBoarding", value: false);
  navigatorFinish(context, const LoginScreen());
}
