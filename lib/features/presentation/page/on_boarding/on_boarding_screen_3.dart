import 'package:flutter/material.dart';
import 'package:hayat_eg/shared/component/constants.dart';

class OnBoardingScreen3 extends StatelessWidget {
  const OnBoardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: sizeConfig.defaultSize! * 8, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/foodDonation.jpg',
                    width: sizeConfig.defaultSize! * 30,
                    height: sizeConfig.defaultSize! * 30,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Food Donation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Color(0xff2E2B6D),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Column(
                  children: [
                    Text('Donating food is an easy and',
                        style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                    Text(' impactful way to help those in need.',
                        style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                    Text('With your help,',
                        style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                    Text('we can provide nutritious meals to ',
                        style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.w600,
                            fontSize: 22)),
                    Text('individuals and families who may be ',
                        style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                    Text('struggling to make ends meet.',
                        style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.w600,
                            fontSize: 22)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
