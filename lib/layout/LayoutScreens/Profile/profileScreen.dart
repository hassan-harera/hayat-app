import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../modules/StartApp/Splash/Splash_view.dart';
import '../../../modules/StartApp/login/Login.dart';
import '../../../modules/StartApp/on_bording/onBordingLayout.dart';
import '../../../outhFolder/google/outh.dart';
import '../../../outhFolder/google/userIngo/userInfo.dart';
import '../../../shared/component/constans.dart';
import '../../../shared/network/local/Cash_helper/cash_helper.dart';
import 'editProfil.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Mohamed Ahmed'),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: size.height / 5,
            ),
            CircleAvatar(
              maxRadius: 80,
              // minRadius: 70,

              backgroundColor: Color(0xffCED9E9),
              child: ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  // matchTextDirection: true,
                  width: size.width,
                  imageUrl:
                      "https://findepartament.com/static/transit/t118/img/text-photo-1.png",
                  placeholder: (context, url) => new Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.amber,
                  ),
                  errorWidget: (context, url, error) => new Icon(
                    Icons.error,
                    size: 80,
                    color: Colors.red,
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                      width: 160.0,
                      height: 160.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber, width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover))),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            Text(
              'Mohamed ahmed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myButton(
                  height: 50,
                  onTap: () {},
                  text: 'edit',
                  radius: 30,
                  width: size.width / 2.5,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: size.width / 20,
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'SHARE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(
                      color: Colors.amber,
                    ),
                    minimumSize: Size(size.width / 2.5, 50),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      myButton(
                          width: 160,
                          radius: 20,
                          text: 'SignOut',
                          onTap: () {
                            Cash_helper.removeData(key: 'token').then((value) {
                              if (value) {
                                myNavigateAndFinish(context, LoginScreen());
                              }
                            });
                          }),
                      Spacer(),
                      myButton(
                          width: 180,
                          radius: 20,
                          text: 'onBoarding',
                          onTap: () {
                            myNavigator(context, OnBoardingScreen());
                          }),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                  myButton(
                      radius: 20,
                      text: 'Splash Screen',
                      onTap: () {
                        Cash_helper.removeData(key: 'token').then((value) {
                          if (value) {
                            myNavigateAndFinish(context, splashView());
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
