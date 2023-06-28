import 'package:flutter/material.dart';
import '../../shared/component/constans.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({super.key});

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
                    'assets/OnboardingDonation.jpg',
                    width: double.infinity,
                    height: sizeConfig.defaultSize! * 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Donations',
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
                  children: [
                    const Text('Welcome to our donations platform!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    const Text(' Our vision is a world',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    const Text('  where donation is further, faster',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    const Text('and directed to',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    const Text(' the people most in need',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
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

// class mycustomCliper extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size) {
//     var path =Path();
//     double? w =sizeConfig.screenWidth!;
//     double? h =sizeConfig.screenHeight!;
//     path.moveTo(0,sizeConfig.defaultSize!*62);
//     path.lineTo(0, h);
//     // path.quadraticBezierTo(0, h, 50,h);
//     path.lineTo(w, h);
//     //  path.quadraticBezierTo(0, h, 50,h);
//     path.lineTo(w,sizeConfig.defaultSize!* 57);
//     path.quadraticBezierTo(sizeConfig.defaultSize!*18, sizeConfig.defaultSize!*52, 0,sizeConfig.defaultSize!*63);
//
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
//
// }
