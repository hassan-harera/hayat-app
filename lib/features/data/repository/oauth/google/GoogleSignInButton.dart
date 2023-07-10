import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/data/repository/oauth/google/userIngo/userInfo.dart';
import 'package:hayat_eg/features/presentation/page/login/LoginCubit/LoginCubit.dart';
import 'package:hayat_eg/features/presentation/page/login/LoginCubit/LoginStates.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat_layout.dart';
import 'package:hayat_eg/shared/component/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'oauth.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;
  double progressNum = 0;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  String? deviceToken;

  @override
  void initState() {
    fcm.getToken().then((token) {
      deviceToken = token;
      print('the device token is :$token');
    });
  }

  int progressNumber() {
    var random = Random();
    var randomNumber = random.nextInt(100);
    print(randomNumber);
    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is GoogleLoginSuccessState) {
          print(state.token);
          myNavigateAndFinish(context, const HayatLayoutScreen());
        } else if (state is LoginErrorState) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text(
                      state.error,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
        }
      },
      builder: (context, state) {
        LoginCubit loginCubit = LoginCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            onPressed: () async {
              User? user =
                  await AuthenticationTest.signInWithGoogle(context: context);

              print(user?.uid);
              if (user != null) {
                await loginCubit.loginWithGoogle(
                    firebaseToken: await user.getIdToken(),
                    deviceToken: deviceToken);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => UserInfoScreen(
                      user: user,
                    ),
                  ),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/google.png"),
                      height: 30.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Google Sign in ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
