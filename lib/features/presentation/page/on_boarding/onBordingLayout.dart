import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/component/constans.dart';
import '../../../shared/network/local/Cash_helper/cash_helper.dart';
import 'onBoradingScreen1.dart';
import 'onBoardingScreen2.dart';
import 'onBoardingSceen3.dart';
import 'onBoradingScreen4.dart';
import '../login/Login.dart';

class BoardingData {
  late String image;
  late String title;
  late String body;

  BoardingData({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingData> boarding = [
    BoardingData(
      image: 'assets/OnboardingDonation.jpg',
      title: 'Screen1 title',
      body: 'Screen1 body',
    ),
    BoardingData(
      image: 'assets/clothesDonation.jpg',
      title: 'Screen2 title',
      body: 'Screen2 body',
    ),
    BoardingData(
      image: 'assets/foodDonation.jpg',
      title: 'Screen3 title',
      body: 'Screen3 body',
    ),
    BoardingData(
      image: 'assets/medicienDonation.jpg',
      title: 'Screen4 title',
      body: 'Screen4 body',
    ),
  ];
  List<Widget> onBoardingScreen = [
    const OnBoardingScreen1(),
    const OnBoardingScreen2(),
    const OnBoardingScreen3(),
    const OnBoardingScreen4()
  ];
  bool isLast = false;

  void submit() {
    Cash_helper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        myNavigateAndFinish(context, LoginScreen());
      }
    });
  }

  var bordController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    sizeConfig().init(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isLast == true ? false : true,
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            setState(() {
              bordController.nextPage(
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.fastLinearToSlowEaseIn);
            });
          },
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: bordController,
                  itemBuilder: (context, index) => onBoardingScreen[index],
                  itemCount: boarding.length,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // here apply smooth indecator
                      Visibility(
                        visible: isLast == true ? false : true,
                        child: SmoothPageIndicator(
                          controller: bordController,
                          count: boarding.length,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Colors.amber,
                            dotHeight: 10,
                            spacing: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isLast == true ? false : true,
                  child: Positioned(
                    top: sizeConfig.defaultSize! * 1,
                    right: 15,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 280, top: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MaterialButton(
                            color: Colors.amber,
                            onPressed: submit,
                            child: const Text(
                              'Skip',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Visibility(
                    visible: isLast == false ? false : true,
                    child: myButton(
                      text: 'Get Started',
                      onTap: () {
                        submit();
                      },
                      width: size.width - 40,
                      radius: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
