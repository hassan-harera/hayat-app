import 'package:flutter/material.dart';

import '../../../shared/component/constans.dart';

class OnBoardingScreen4 extends StatelessWidget {
  const OnBoardingScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: sizeConfig.defaultSize! * 8, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/medicienDonation.jpg',
                    width: double.infinity,
                    height: sizeConfig.defaultSize! * 30,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Donate Medicines',
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
                Column(
                  children: const [
                    Text('We try to improve access to vital ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('medicines for those in need.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('As a member of our team, you',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('will be making a direct and',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('meaningful impact on the lives of',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('people who may not have access',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('to the medicines they require to',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Text('maintain their health .',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
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
